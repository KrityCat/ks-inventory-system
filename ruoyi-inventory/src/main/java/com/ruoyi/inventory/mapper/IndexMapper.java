package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.Index;

import java.util.List;

public interface IndexMapper {

    /**
     * 销售金额与毛利润查询
     */
    Index salesAmountQuery();

    /**
     * 待审核单据查询
     */
    Index salesNotTakeEffectQuery();

    /**
     * 货品库存积压预警查询
     */
    List<Index> productOverstockQuery(Index bo);

    /**
     * 货品库存不足预警查询
     */
    List<Index> productDangerQuery(Index bo);

    /**
     * 积压3个月未出预警查询
     */
    List<Index> productThreeDangerQuery(Index bo);

    /**
     * 积压6个月未出预警查询
     */
    List<Index> productSixDangerQuery(Index bo);

    /**
     * 积压12个月未出预警查询
     */
    List<Index> productTwelveDangerQuery(Index bo);


}
