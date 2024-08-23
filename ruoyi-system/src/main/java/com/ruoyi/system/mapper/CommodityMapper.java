package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.Commodity;

import java.util.List;

/**
 * 商品资料Mapper接口
 *
 * @author KrityCat
 */
public interface CommodityMapper {
    /**
     * 查询商品资料
     *
     * @param commodityId 商品资料主键
     * @return 商品资料
     */
    Commodity selectCommodityByCommodityId(Long commodityId);

    /**
     * 货品名称查询
     */
    Commodity selectCommodityByCommodityName(String commodityName);

    /**
     * 查询商品资料列表
     *
     * @param commodity 商品资料
     * @return 商品资料集合
     */
    List<Commodity> selectCommodityList(Commodity commodity);

    /**
     * 新增商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    int insertCommodity(Commodity commodity);

    /**
     * 修改商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    int updateCommodity(Commodity commodity);

    /**
     * 删除商品资料
     *
     * @param commodityId 商品资料主键
     * @return 结果
     */
    int deleteCommodityByCommodityId(Long commodityId);

    /**
     * 批量删除商品资料
     *
     * @param commodityIds 需要删除的数据主键集合
     * @return 结果
     */
    int deleteCommodityByCommodityIds(Long[] commodityIds);
}
