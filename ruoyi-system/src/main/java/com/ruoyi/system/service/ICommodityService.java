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
    Commodity selectCommodityByCommodityId(Long commodityId);

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
     * 批量删除商品资料
     *
     * @param commodityIds 需要删除的商品资料主键集合
     * @return 结果
     */
    int deleteCommodityByCommodityIds(Long[] commodityIds);

    /**
     * 删除商品资料信息
     *
     * @param commodityId 商品资料主键
     * @return 结果
     */
    int deleteCommodityByCommodityId(Long commodityId);

    /**
     * 导入商品数据
     *
     * @param commodityList   商品数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    String importCommodity(List<Commodity> commodityList, Boolean isUpdateSupport, String operName);

}
