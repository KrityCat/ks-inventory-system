package com.ruoyi.system.service.impl;

import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.CommodityType;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.system.mapper.CommodityTypeMapper;
import com.ruoyi.system.service.ICommodityTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 商品类型 服务实现
 *
 * @author KrityCat
 */
@Service
public class CommodityTypeServiceImpl implements ICommodityTypeService {

    @Autowired
    private CommodityTypeMapper commodityTypeMapper;

    /**
     * 查询商品类型数据
     *
     * @param type 商品类型
     * @return 商品类型集合
     */
    @Override
    public List<CommodityType> selectCommodityTypeList(CommodityType type) {
        return commodityTypeMapper.selectCommodityTypeList(type);
    }

    /**
     * 查询商品类型树结构信息
     *
     * @param type 商品类型
     * @return 商品类型树信息集合
     */
    @Override
    public List<TreeSelect> selectCommodityTypeTreeList(CommodityType type) {
        List<CommodityType> types = SpringUtils.getAopProxy(this).selectCommodityTypeList(type);
        return buildCommodityTypeTreeSelect(types);
    }

    /**
     * 构建前端所需要树结构
     *
     * @param types 商品类型
     * @return 树结构列表
     */
    @Override
    public List<CommodityType> buildCommodityTypeTree(List<CommodityType> types) {
        List<CommodityType> returnList = new ArrayList<CommodityType>();
        List<Long> tempList = types.stream().map(CommodityType::getCommodityTypeId).collect(Collectors.toList());
        for (CommodityType type : types) {
            // 如果是顶级节点, 遍历该父节点的所有子节点
            if (!tempList.contains(type.getParentId())) {
                recursionFn(types, type);
                returnList.add(type);
            }
        }
        if (returnList.isEmpty()) {
            returnList = types;
        }
        return returnList;
    }

    /**
     * 构建前端所需要下拉树结构
     *
     * @param types 商品类型
     * @return 下拉树结构列表
     */
    @Override
    public List<TreeSelect> buildCommodityTypeTreeSelect(List<CommodityType> types) {
        List<CommodityType> typeTrees = buildCommodityTypeTree(types);
        return typeTrees.stream().map(TreeSelect::new).collect(Collectors.toList());
    }

    /**
     * 根据商品类型ID查询信息
     *
     * @param commodityId 商品类型ID
     * @return 部门信息
     */
    @Override
    public CommodityType selectTypeById(Long commodityId) {
        return commodityTypeMapper.selectTypeById(commodityId);
    }

    /**
     * 根据ID查询所有子商品类型（正常状态）
     *
     * @param commodityId 商品类型ID
     * @return 子部门数
     */
    @Override
    public int selectNormalChildrenTypeById(Long commodityId) {
        return commodityTypeMapper.selectNormalChildrenTypeById(commodityId);
    }

    /**
     * 是否存在子节点
     *
     * @param deptId 部门ID
     * @return 结果
     */
    @Override
    public boolean hasChildByCommodityId(Long deptId) {
        int result = commodityTypeMapper.hasChildByCommodityId(deptId);
        return result > 0;
    }

    /**
     * 校验商品类型是否唯一
     *
     * @param type 商品类型
     * @return 结果
     */
    @Override
    public boolean checkTypeNameUnique(CommodityType type) {
        Long commodityId = StringUtils.isNull(type.getCommodityTypeId()) ? -1L : type.getCommodityTypeId();
        CommodityType info = commodityTypeMapper.checkTypeNameUnique(type.getCommodityTypeName(), type.getParentId());
        if (StringUtils.isNotNull(info) && info.getCommodityTypeId().longValue() != commodityId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 新增保存商品类型
     *
     * @param type 商品类型
     * @return 结果
     */
    @Override
    public int insertType(CommodityType type) {
        CommodityType info = commodityTypeMapper.selectTypeById(type.getParentId());
        // 如果父节点不为正常状态,则不允许新增子节点
        if (!UserConstants.DEPT_NORMAL.equals(info.getStatus())) {
            throw new ServiceException("商品类型停用，不允许新增");
        }
        type.setAncestors(info.getAncestors() + "," + type.getParentId());
        return commodityTypeMapper.insertType(type);
    }

    /**
     * 修改保存商品类型
     *
     * @param type 商品类型
     * @return 结果
     */
    @Override
    public int updateType(CommodityType type) {
        CommodityType newParentType = commodityTypeMapper.selectTypeById(type.getParentId());
        CommodityType oldType = commodityTypeMapper.selectTypeById(type.getCommodityTypeId());
        if (StringUtils.isNotNull(newParentType) && StringUtils.isNotNull(oldType)) {
            String newAncestors = newParentType.getAncestors() + "," + newParentType.getCommodityTypeId();
            String oldAncestors = oldType.getAncestors();
            type.setAncestors(newAncestors);
            updateTypeChildren(type.getCommodityTypeId(), newAncestors, oldAncestors);
        }
        int result = commodityTypeMapper.updateType(type);
        if (UserConstants.DEPT_NORMAL.equals(type.getStatus()) && StringUtils.isNotEmpty(type.getAncestors())
                && !StringUtils.equals("0", type.getAncestors())) {
            // 如果该部门是启用状态，则启用该部门的所有上级部门
            updateParentTypeStatusNormal(type);
        }
        return result;
    }

    /**
     * 修改该商品类型的父级部门状态
     *
     * @param type 当前商品类型
     */
    private void updateParentTypeStatusNormal(CommodityType type) {
        String ancestors = type.getAncestors();
        Long[] commodityIds = Convert.toLongArray(ancestors);
        commodityTypeMapper.updateTypeStatusNormal(commodityIds);
    }

    /**
     * 修改子元素关系
     *
     * @param commodityId  被修改的商品类型ID
     * @param newAncestors 新的父ID集合
     * @param oldAncestors 旧的父ID集合
     */
    public void updateTypeChildren(Long commodityId, String newAncestors, String oldAncestors) {
        List<CommodityType> children = commodityTypeMapper.selectChildrenTypeById(commodityId);
        for (CommodityType child : children) {
            child.setAncestors(child.getAncestors().replaceFirst(oldAncestors, newAncestors));
        }
        if (children.size() > 0) {
            commodityTypeMapper.updateTypeChildren(children);
        }
    }

    /**
     * 删除商品类型管理信息
     *
     * @param commodityId 商品类型ID
     * @return 结果
     */
    @Override
    public int deleteTypeById(Long commodityId) {
        return commodityTypeMapper.deleteTypeById(commodityId);
    }

    /**
     * 递归列表
     */
    private void recursionFn(List<CommodityType> list, CommodityType p) {
        // 得到子节点列表
        List<CommodityType> childList = getChildList(list, p);
        p.setChildren(childList);
        for (CommodityType tChild : childList) {
            if (hasChild(list, tChild)) {
                recursionFn(list, tChild);
            }
        }
    }

    /**
     * 得到子节点列表
     */
    private List<CommodityType> getChildList(List<CommodityType> list, CommodityType p) {
        List<CommodityType> tlist = new ArrayList<CommodityType>();
        Iterator<CommodityType> it = list.iterator();
        while (it.hasNext()) {
            CommodityType n = (CommodityType) it.next();
            if (StringUtils.isNotNull(n.getParentId()) && n.getParentId().longValue() == p.getCommodityTypeId().longValue()) {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<CommodityType> list, CommodityType p) {
        return getChildList(list, p).size() > 0;
    }
}
