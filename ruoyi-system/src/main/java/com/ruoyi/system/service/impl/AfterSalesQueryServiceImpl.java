package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;
import com.ruoyi.system.mapper.DetailServiceMapper;
import com.ruoyi.system.mapper.HeadServiceMapper;
import com.ruoyi.system.service.AfterSalesQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 售后单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class AfterSalesQueryServiceImpl implements AfterSalesQueryService {

    @Autowired
    private HeadServiceMapper headServiceMapper;

    @Autowired
    private DetailServiceMapper detailServiceMapper;

    /**
     * @param bo 单据信息
     * @return 售后头单查询
     */
    @Override
    public List<HeadService> salesHeadServiceQuery(HeadService bo) {
        return headServiceMapper.headServiceQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 售后明细单查询
     */
    @Override
    public List<DetailService> salesDetailServiceQuery(DetailService bo) {
        return detailServiceMapper.selectDetailServiceQuery(bo);
    }

    /**
     * @param systematicService 系统单号
     * @return 单据详情
     */
    @Override
    public HeadService selectSalesOrderById(String systematicService) {
        return headServiceMapper.selectHeadServiceById(systematicService);
    }

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    @Override
    @Transactional
    public int delAfterSales(List<DetailService> bo) {
        detailServiceMapper.delDetailService(bo);
        return headServiceMapper.delHeadService(bo);
    }
}
