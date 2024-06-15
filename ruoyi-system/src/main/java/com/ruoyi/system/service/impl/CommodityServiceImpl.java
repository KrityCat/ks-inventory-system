package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.Commodity;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.mapper.CommodityMapper;
import com.ruoyi.system.mapper.CommodityTypeMapper;
import com.ruoyi.system.service.ICommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 商品资料Service业务层处理
 *
 * @author KrityCat
 */
@Service
public class CommodityServiceImpl implements ICommodityService {

    @Autowired
    private CommodityMapper commodityMapper;

    @Autowired
    private CommodityTypeMapper commodityTypeMapper;



    /**
     * 查询商品资料
     *
     * @param commodityId 商品资料主键
     * @return 商品资料
     */
    @Override
    public Commodity selectCommodityByCommodityId(Long commodityId) {
        return commodityMapper.selectCommodityByCommodityId(commodityId);
    }

    /**
     * 查询商品资料列表
     *
     * @param commodity 商品资料
     * @return 商品资料
     */
    @Override
    public List<Commodity> selectCommodityList(Commodity commodity) {
        return commodityMapper.selectCommodityList(commodity);
    }

    /**
     * 新增商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    @Override
    public int insertCommodity(Commodity commodity) {
        commodity.setCreateTime(DateUtils.getNowDate());
        return commodityMapper.insertCommodity(commodity);
    }

    /**
     * 修改商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    @Override
    public int updateCommodity(Commodity commodity) {
        commodity.setUpdateTime(DateUtils.getNowDate());
        return commodityMapper.updateCommodity(commodity);
    }

    /**
     * 批量删除商品资料
     *
     * @param commodityIds 需要删除的商品资料主键
     * @return 结果
     */
    @Override
    public int deleteCommodityByCommodityIds(Long[] commodityIds) {
        return commodityMapper.deleteCommodityByCommodityIds(commodityIds);
    }

    /**
     * 删除商品资料信息
     *
     * @param commodityId 商品资料主键
     * @return 结果
     */
    @Override
    public int deleteCommodityByCommodityId(Long commodityId) {
        return commodityMapper.deleteCommodityByCommodityId(commodityId);
    }
}
