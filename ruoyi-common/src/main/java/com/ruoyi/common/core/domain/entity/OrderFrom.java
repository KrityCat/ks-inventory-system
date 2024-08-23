package com.ruoyi.common.core.domain.entity;


import java.util.List;

/**
 * 订单汇总对象 OrderFrom
 *
 * @author KrityCat
 */
public class OrderFrom extends HeadOrderForm {

    private List<DetailOrderForm> details;

    @Override
    public List<DetailOrderForm> getDetails() {
        return details;
    }

    @Override
    public void setDetails(List<DetailOrderForm> details) {
        this.details = details;
    }

}
