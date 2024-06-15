package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.Commodity;

import java.util.List;

/**
 * 商品资料Service接口
 *
 * @author KrityCat
 */
public interface ICommodityService {
    /**
     * 查询商品资料
     *
     * @param commodityId 商品资料主键
     * @return 商品资料
     */
    public Commodity selectCommodityByCommodityId(Long commodityId);

    /**
     * 查询商品资料列表
     *
     * @param commodity 商品资料
     * @return 商品资料集合
     */
    public List<Commodity> selectCommodityList(Commodity commodity);

    /**
     * 新增商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    public int insertCommodity(Commodity commodity);

    /**
     * 修改商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    public int updateCommodity(Commodity commodity);

    /**
     * 批量删除商品资料
     *
     * @param commodityIds 需要删除的商品资料主键集合
     * @return 结果
     */
    public int deleteCommodityByCommodityIds(Long[] commodityIds);

    /**
     * 删除商品资料信息
     *
     * @param commodityId 商品资料主键
     * @return 结果
     */
    public int deleteCommodityByCommodityId(Long commodityId);
}
