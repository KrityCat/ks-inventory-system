package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.CommodityType;

import java.util.List;

/**
 * 商品类型 服务层
 *
 * @author KrityCat
 */
public interface ICommodityTypeService {
    /**
     * 查询商品类型数据
     *
     * @param type 商品类型
     * @return 商品类型集合
     */
    List<CommodityType> selectCommodityTypeList(CommodityType type);

    /**
     * 查询商品类型树结构信息
     *
     * @param type 商品类型
     * @return 商品类型树信息集合
     */
    List<TreeSelect> selectCommodityTypeTreeList(CommodityType type);

    /**
     * 构建前端所需要树结构
     *
     * @param types 商品列表
     * @return 树结构列表
     */
    List<CommodityType> buildCommodityTypeTree(List<CommodityType> types);

    /**
     * 构建前端所需要下拉树结构
     *
     * @param types 商品列表
     * @return 下拉树结构列表
     */
    public List<TreeSelect> buildCommodityTypeTreeSelect(List<CommodityType> types);

    /**
     * 根据商品类型ID查询信息
     *
     * @param commodityId 商品类型ID
     * @return 部门信息
     */
    CommodityType selectTypeById(Long commodityId);

    /**
     * 根据ID查询所有子商品类型（正常状态）
     *
     * @param commodityId 商品类型ID
     * @return 子部门数
     */
    int selectNormalChildrenTypeById(Long commodityId);

    /**
     * 是否存在商品类型子节点
     *
     * @param commodityId 商品类型ID
     * @return 结果
     */
    boolean hasChildByCommodityId(Long commodityId);

    /**
     * 校验商品类型是否唯一
     *
     * @param type 商品类型
     * @return 结果
     */
    boolean checkTypeNameUnique(CommodityType type);

    /**
     * 新增保存商品类型
     *
     * @param type 商品类型
     * @return 结果
     */
    int insertType(CommodityType type);

    /**
     * 修改保存商品类型
     *
     * @param type 商品类型
     * @return 结果
     */
    int updateType(CommodityType type);

    /**
     * 删除商品类型信息
     *
     * @param commodityId 商品ID
     * @return 结果
     */
    int deleteTypeById(Long commodityId);
}
