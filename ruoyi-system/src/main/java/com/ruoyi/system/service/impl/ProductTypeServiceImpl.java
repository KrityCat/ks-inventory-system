package com.ruoyi.system.service.impl;

import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.ProductType;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.system.mapper.ProductTypeMapper;
import com.ruoyi.system.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 货品类型 服务实现
 *
 * @author KrityCat
 */
@Service
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    private ProductTypeMapper typeMapper;

    /**
     * 查询货品类型数据
     *
     * @param type 货品类型
     * @return 货品类型集合
     */
    @Override
    public List<ProductType> selectProductTypeList(ProductType type) {
        return typeMapper.selectProductTypeList(type);
    }

    /**
     * 查询货品类型树结构信息
     *
     * @param type 货品类型
     * @return 货品类型树信息集合
     */
    @Override
    public List<TreeSelect> selectProductTypeTreeList(ProductType type) {
        List<ProductType> types = SpringUtils.getAopProxy(this).selectProductTypeList(type);
        return buildProductTypeTreeSelect(types);
    }

    /**
     * 构建前端所需要树结构
     *
     * @param types 货品类型
     * @return 树结构列表
     */
    @Override
    public List<ProductType> buildProductTypeTree(List<ProductType> types) {
        List<ProductType> returnList = new ArrayList<ProductType>();
        List<Long> tempList = types.stream().map(ProductType::getProductTypeId).collect(Collectors.toList());
        for (ProductType type : types) {
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
     * @param types 货品类型
     * @return 下拉树结构列表
     */
    @Override
    public List<TreeSelect> buildProductTypeTreeSelect(List<ProductType> types) {
        List<ProductType> typeTrees = buildProductTypeTree(types);
        return typeTrees.stream().map(TreeSelect::new).collect(Collectors.toList());
    }

    /**
     * 根据货品类型ID查询信息
     *
     * @param productId 货品类型ID
     * @return 部门信息
     */
    @Override
    public ProductType selectTypeById(Long productId) {
        return typeMapper.selectTypeById(productId);
    }

    /**
     * 根据ID查询所有子货品类型（正常状态）
     *
     * @param productId 货品类型ID
     * @return 子部门数
     */
    @Override
    public int selectNormalChildrenTypeById(Long productId) {
        return typeMapper.selectNormalChildrenTypeById(productId);
    }

    /**
     * 是否存在子节点
     *
     * @param deptId 部门ID
     * @return 结果
     */
    @Override
    public boolean hasChildByProductId(Long deptId) {
        int result = typeMapper.hasChildByProductId(deptId);
        return result > 0;
    }

    /**
     * 校验货品类型是否唯一
     *
     * @param type 货品类型
     * @return 结果
     */
    @Override
    public boolean checkTypeNameUnique(ProductType type) {
        Long productId = StringUtils.isNull(type.getProductTypeId()) ? -1L : type.getProductTypeId();
        ProductType info = typeMapper.checkTypeNameUnique(type.getProductTypeName(), type.getParentId());
        if (StringUtils.isNotNull(info) && info.getProductTypeId().longValue() != productId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 新增保存货品类型
     *
     * @param type 货品类型
     * @return 结果
     */
    @Override
    public int insertType(ProductType type) {
        ProductType info = typeMapper.selectTypeById(type.getParentId());
        // 如果父节点不为正常状态,则不允许新增子节点
        if (!UserConstants.DEPT_NORMAL.equals(info.getStatus())) {
            throw new ServiceException("货品类型停用，不允许新增");
        }
        type.setAncestors(info.getAncestors() + "," + type.getParentId());
        return typeMapper.insertType(type);
    }

    /**
     * 修改保存货品类型
     *
     * @param type 货品类型
     * @return 结果
     */
    @Override
    public int updateType(ProductType type) {
        ProductType newParentType = typeMapper.selectTypeById(type.getParentId());
        ProductType oldType = typeMapper.selectTypeById(type.getProductTypeId());
        if (StringUtils.isNotNull(newParentType) && StringUtils.isNotNull(oldType)) {
            String newAncestors = newParentType.getAncestors() + "," + newParentType.getProductTypeId();
            String oldAncestors = oldType.getAncestors();
            type.setAncestors(newAncestors);
            updateTypeChildren(type.getProductTypeId(), newAncestors, oldAncestors);
        }
        int result = typeMapper.updateType(type);
        if (UserConstants.DEPT_NORMAL.equals(type.getStatus()) && StringUtils.isNotEmpty(type.getAncestors())
                && !StringUtils.equals("0", type.getAncestors())) {
            // 如果该部门是启用状态，则启用该部门的所有上级部门
            updateParentTypeStatusNormal(type);
        }
        return result;
    }

    /**
     * 修改该货品类型的父级部门状态
     *
     * @param type 当前货品类型
     */
    private void updateParentTypeStatusNormal(ProductType type) {
        String ancestors = type.getAncestors();
        Long[] productIds = Convert.toLongArray(ancestors);
        typeMapper.updateTypeStatusNormal(productIds);
    }

    /**
     * 修改子元素关系
     *
     * @param productId    被修改的货品类型ID
     * @param newAncestors 新的父ID集合
     * @param oldAncestors 旧的父ID集合
     */
    public void updateTypeChildren(Long productId, String newAncestors, String oldAncestors) {
        List<ProductType> children = typeMapper.selectChildrenTypeById(productId);
        for (ProductType child : children) {
            child.setAncestors(child.getAncestors().replaceFirst(oldAncestors, newAncestors));
        }
        if (children.size() > 0) {
            typeMapper.updateTypeChildren(children);
        }
    }

    /**
     * 删除货品类型管理信息
     *
     * @param productId 货品类型ID
     * @return 结果
     */
    @Override
    public int deleteTypeById(Long productId) {
        return typeMapper.deleteTypeById(productId);
    }

    /**
     * 递归列表
     */
    private void recursionFn(List<ProductType> list, ProductType p) {
        // 得到子节点列表
        List<ProductType> childList = getChildList(list, p);
        p.setChildren(childList);
        for (ProductType tChild : childList) {
            if (hasChild(list, tChild)) {
                recursionFn(list, tChild);
            }
        }
    }

    /**
     * 得到子节点列表
     */
    private List<ProductType> getChildList(List<ProductType> list, ProductType p) {
        List<ProductType> tlist = new ArrayList<ProductType>();
        Iterator<ProductType> it = list.iterator();
        while (it.hasNext()) {
            ProductType n = (ProductType) it.next();
            if (StringUtils.isNotNull(n.getParentId()) && n.getParentId().longValue() == p.getProductTypeId().longValue()) {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<ProductType> list, ProductType p) {
        return getChildList(list, p).size() > 0;
    }
}
