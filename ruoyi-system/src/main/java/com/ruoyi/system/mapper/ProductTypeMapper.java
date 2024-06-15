package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 货品类型管理 数据层
 *
 * @author KrityCat
 */
public interface ProductTypeMapper {
    /**
     * 查询货品类型管理数据
     *
     * @param type 货品类型信息
     * @return 货品类型信息集合
     */
    List<ProductType> selectProductTypeList(ProductType type);

    /**
     * 根据货品类型ID查询信息
     *
     * @param productId 货品类型ID
     * @return 货品类型信息
     */
    ProductType selectTypeById(Long productId);

    /**
     * 根据ID查询所有子货品类型
     *
     * @param productId 货品类型ID
     * @return 货品类型列表
     */
    List<ProductType> selectChildrenTypeById(Long productId);

    /**
     * 根据ID查询所有子货品类型（正常状态）
     *
     * @param productId 货品类型ID
     * @return 子货品类型数
     */
    int selectNormalChildrenTypeById(Long productId);

    /**
     * 是否存在子节点
     *
     * @param deptId 货品类型ID
     * @return 结果
     */
    int hasChildByProductId(Long deptId);

    /**
     * 校验货品类型名称是否唯一
     *
     * @param productTypeName 货品类型名称
     * @param parentId    父货品类型ID
     * @return 结果
     */
    ProductType checkTypeNameUnique(@Param("productTypeName") String productTypeName, @Param("parentId") Long parentId);

    /**
     * 新增货品类型信息
     *
     * @param type 货品类型信息
     * @return 结果
     */
    int insertType(ProductType type);

    /**
     * 修改货品类型信息
     *
     * @param type 货品类型信息
     * @return 结果
     */
    int updateType(ProductType type);

    /**
     * 修改所在货品类型正常状态
     *
     * @param productIds 货品类型ID组
     */
    void updateTypeStatusNormal(Long[] productIds);

    /**
     * 修改子元素关系
     *
     * @param types 子元素
     * @return 结果
     */
    int updateTypeChildren(@Param("types") List<ProductType> types);

    /**
     * 删除货品类型管理信息
     *
     * @param productId 货品类型ID
     * @return 结果
     */
    int deleteTypeById(Long productId);
}
