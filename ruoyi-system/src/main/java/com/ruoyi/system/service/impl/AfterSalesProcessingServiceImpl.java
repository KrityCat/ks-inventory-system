package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;
import com.ruoyi.common.core.domain.entity.ServiceFrom;
import com.ruoyi.system.mapper.DetailServiceMapper;
import com.ruoyi.system.mapper.HeadServiceMapper;
import com.ruoyi.system.service.AfterSalesProcessingService;
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
public class AfterSalesProcessingServiceImpl implements AfterSalesProcessingService {

    @Autowired
    private HeadServiceMapper headServiceMapper;

    @Autowired
    private DetailServiceMapper detailServiceMapper;

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
     * @return 保存售后出库单据信息
     */
    @Override
    public int saveAfterSales(ServiceFrom bo) {
        long count = headServiceMapper.selectHeadServiceByCount(bo).size();
        List<DetailService> details = bo.getDetails();
        if (count == 0) {
            detailServiceMapper.addDetailService(details);
            headServiceMapper.addHeadService(bo);
        } else {
            detailServiceMapper.delDetailService(details);
            detailServiceMapper.addDetailService(details);
            headServiceMapper.updateHeadService(bo);
        }
        return 1;
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
