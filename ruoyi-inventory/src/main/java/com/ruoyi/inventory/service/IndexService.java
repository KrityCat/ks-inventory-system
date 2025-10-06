package com.ruoyi.inventory.service;

import com.ruoyi.common.core.domain.entity.Index;

import java.util.List;

/**
 * 主页 业务层
 *
 * @author KrityCat
 */
public interface IndexService {

    /**
     * @return 销售金额与毛利润查询
     */
    Index salesAmountQuery();

    /**
     * @return 待审核单据查询
     */
    Index salesNotTakeEffectQuery();


    /**
     * 根据货品库存积压预警查询货品列表
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Index> productOverstockQuery(Index bo);

    /**
     * 根据货品库存不足预警查询货品列表
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Index> productDangerQuery(Index bo);

    /**
     * 积压3个月未出预警查询
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Index> productThreeDangerQuery(Index bo);

    /**
     * 积压6个月未出预警查询
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Index> productSixDangerQuery(Index bo);

    /**
     * 积压12个月未出预警查询
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Index> productTwelveDangerQuery(Index bo);

}
