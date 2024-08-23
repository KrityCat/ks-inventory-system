package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.common.core.domain.entity.OrderFrom;
import com.ruoyi.system.mapper.DetailOrderFormMapper;
import com.ruoyi.system.mapper.HeadOrderFormMapper;
import com.ruoyi.system.service.SalesOrderProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 销售订单制作 业务层处理
 *
 * @author KrityCat
 */
@Service
public class SalesOrderProcessingServiceImpl implements SalesOrderProcessingService {

    @Autowired
    private HeadOrderFormMapper headOrderFormMapper;

    @Autowired
    private DetailOrderFormMapper detailOrderFormMapper;

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    @Override
    public HeadOrderForm selectSalesOrderFormById(String systematicOrderForm) {
        return headOrderFormMapper.selectHeadOrderFormById(systematicOrderForm);
    }

    /**
     * @param bo 订单信息
     * @return 保存销售订单信息
     */
    @Override
    public int saveSalesOrderForm(OrderFrom bo) {
        long count = headOrderFormMapper.selectHeadOrderFormByCount(bo).size();
        List<DetailOrderForm> detail = bo.getDetails();
        if (count == 0) {
            detailOrderFormMapper.addDetailOrderForm(detail);
            headOrderFormMapper.addHeadOrderForm(bo);
        } else {
            detailOrderFormMapper.delDetailOrderForm(detail);
            detailOrderFormMapper.addDetailOrderForm(detail);
            headOrderFormMapper.updateHeadOrderForm(bo);
        }
        return 1;
    }

    /**
     * @param bo 订单信息
     * @return 删除销售订单信息
     */
    @Override
    @Transactional
    public int delSalesOrder(List<DetailOrderForm> bo) {
        detailOrderFormMapper.delDetailOrderForm(bo);
        return headOrderFormMapper.delHeadOrderForm(bo);
    }
}
