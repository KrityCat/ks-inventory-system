package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.Index;
import com.ruoyi.inventory.mapper.IndexMapper;
import com.ruoyi.inventory.service.IndexService;
import jakarta.validation.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 主页 业务层处理
 *
 * @author KrityCat
 */
@Service
public class IndexServiceImpl implements IndexService {

    @Autowired
    protected Validator validator;

    @Autowired
    private IndexMapper indexMapper;

    /**
     * @return 销售金额与毛利润查询
     */
    @Override
    public Index salesAmountQuery() {
        return indexMapper.salesAmountQuery();
    }

    /**
     * @return 待审核单据查询
     */
    @Override
    public Index salesNotTakeEffectQuery() {
        return indexMapper.salesNotTakeEffectQuery();
    }


    /**
     * 货品库存积压预警查询
     */
    @Override
    public List<Index> productOverstockQuery(Index bo) {
        return indexMapper.productOverstockQuery(bo);
    }

    /**
     * 货品库存不足预警查询
     */
    @Override
    public List<Index> productDangerQuery(Index bo) {
        return indexMapper.productDangerQuery(bo);
    }

    /**
     * 积压3个月未出预警查询
     */
    @Override
    public List<Index> productThreeDangerQuery(Index bo) {
        return indexMapper.productThreeDangerQuery(bo);
    }

    /**
     * 积压6个月未出预警查询
     */
    @Override
    public List<Index> productSixDangerQuery(Index bo) {
        return indexMapper.productSixDangerQuery(bo);
    }

    /**
     * 积压12个月未出预警查询
     */
    @Override
    public List<Index> productTwelveDangerQuery(Index bo) {
        return indexMapper.productTwelveDangerQuery(bo);
    }
}
