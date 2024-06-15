package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.CommodityType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品类型管理 数据层
 *
 * @author KrityCat
 */
public interface CommodityTypeMapper {
    /**
     * 查询商品类型管理数据
     *
     * @param type 商品类型信息
     * @return 商品类型信息集合
     */
    List<CommodityType> selectCommodityTypeList(CommodityType type);

    /**
     * 根据商品类型ID查询信息
     *
     * @param commodityId 商品类型ID
     * @return 商品类型信息
     */
    CommodityType selectTypeById(Long commodityId);

    /**
     * 根据ID查询所有子商品类型
     *
     * @param commodityId 商品类型ID
     * @return 商品类型列表
     */
    List<CommodityType> selectChildrenTypeById(Long commodityId);

    /**
     * 根据ID查询所有子商品类型（正常状态）
     *
     * @param commodityId 商品类型ID
     * @return 子商品类型数
     */
    int selectNormalChildrenTypeById(Long commodityId);

    /**
     * 是否存在子节点
     *
     * @param deptId 商品类型ID
     * @return 结果
     */
    int hasChildByCommodityId(Long deptId);

    /**
     * 校验商品类型名称是否唯一
     *
     * @param commodityTypeName 商品类型名称
     * @param parentId    父商品类型ID
     * @return 结果
     */
    CommodityType checkTypeNameUnique(@Param("commodityTypeName") String commodityTypeName, @Param("parentId") Long parentId);

    /**
     * 新增商品类型信息
     *
     * @param type 商品类型信息
     * @return 结果
     */
    int insertType(CommodityType type);

    /**
     * 修改商品类型信息
     *
     * @param type 商品类型信息
     * @return 结果
     */
    int updateType(CommodityType type);

    /**
     * 修改所在商品类型正常状态
     *
     * @param commodityIds 商品类型ID组
     */
    void updateTypeStatusNormal(Long[] commodityIds);

    /**
     * 修改子元素关系
     *
     * @param types 子元素
     * @return 结果
     */
    int updateTypeChildren(@Param("types") List<CommodityType> types);

    /**
     * 删除商品类型管理信息
     *
     * @param commodityId 商品类型ID
     * @return 结果
     */
    int deleteTypeById(Long commodityId);
}
