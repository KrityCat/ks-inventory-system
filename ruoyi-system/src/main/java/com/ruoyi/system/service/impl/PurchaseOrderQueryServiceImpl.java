package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.system.mapper.DetailOrderFormMapper;
import com.ruoyi.system.mapper.HeadOrderFormMapper;
import com.ruoyi.system.service.PurchaseOrderQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 销售订单 业务层处理
 *
 * @author KrityCat
 */
@Service
public class PurchaseOrderQueryServiceImpl implements PurchaseOrderQueryService {

    @Autowired
    private HeadOrderFormMapper headOrderFormMapper;

    @Autowired
    private DetailOrderFormMapper detailOrderFormMapper;


    /**
     * @param bo 订单信息
     * @return 销售订单头单查询
     */
    @Override
    public List<HeadOrderForm> purchaseHeadOrderFormQuery(HeadOrderForm bo) {
        return headOrderFormMapper.headOrderFormQuery(bo);
    }

    /**
     * @param bo 订单信息
     * @return 销售订单明细单查询
     */
    @Override
    public List<DetailOrderForm> purchaseDetailOrderFormQuery(DetailOrderForm bo) {
        return detailOrderFormMapper.selectDetailOrderFormQuery(bo);
    }

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    @Override
    public HeadOrderForm selectPurchaseOrderFormById(String systematicOrderForm) {
        return headOrderFormMapper.selectHeadOrderFormById(systematicOrderForm);
    }

    /**
     * @param bo 订单信息
     * @return 删除采购订单信息
     */
    @Override
    @Transactional
    public int delPurchaseOrderForm(List<DetailOrderForm> bo) {
        detailOrderFormMapper.delDetailOrderForm(bo);
        return headOrderFormMapper.delHeadOrderForm(bo);
    }
}
