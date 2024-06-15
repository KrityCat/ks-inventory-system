package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.ProductType;

import java.util.List;

/**
 * 货品类型 服务层
 *
 * @author KrityCat
 */
public interface ProductTypeService {
    /**
     * 查询货品类型数据
     *
     * @param type 货品类型
     * @return 货品类型集合
     */
    List<ProductType> selectProductTypeList(ProductType type);

    /**
     * 查询货品类型树结构信息
     *
     * @param type 货品类型
     * @return 货品类型树信息集合
     */
    List<TreeSelect> selectProductTypeTreeList(ProductType type);

    /**
     * 构建前端所需要树结构
     *
     * @param types 货品列表
     * @return 树结构列表
     */
    List<ProductType> buildProductTypeTree(List<ProductType> types);

    /**
     * 构建前端所需要下拉树结构
     *
     * @param types 货品列表
     * @return 下拉树结构列表
     */
    public List<TreeSelect> buildProductTypeTreeSelect(List<ProductType> types);

    /**
     * 根据货品类型ID查询信息
     *
     * @param productId 货品类型ID
     * @return 部门信息
     */
    ProductType selectTypeById(Long productId);

    /**
     * 根据ID查询所有子货品类型（正常状态）
     *
     * @param productId 货品类型ID
     * @return 子部门数
     */
    int selectNormalChildrenTypeById(Long productId);

    /**
     * 是否存在货品类型子节点
     *
     * @param productId 货品类型ID
     * @return 结果
     */
    boolean hasChildByProductId(Long productId);

    /**
     * 校验货品类型是否唯一
     *
     * @param type 货品类型
     * @return 结果
     */
    boolean checkTypeNameUnique(ProductType type);

    /**
     * 新增保存货品类型
     *
     * @param type 货品类型
     * @return 结果
     */
    int insertType(ProductType type);

    /**
     * 修改保存货品类型
     *
     * @param type 货品类型
     * @return 结果
     */
    int updateType(ProductType type);

    /**
     * 删除货品类型信息
     *
     * @param productId 货品ID
     * @return 结果
     */
    int deleteTypeById(Long productId);
}
