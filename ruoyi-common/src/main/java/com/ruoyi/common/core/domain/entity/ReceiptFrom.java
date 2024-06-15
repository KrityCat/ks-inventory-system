package com.ruoyi.common.core.domain.entity;


import java.util.List;

/**
 * 单据汇总对象 ReceiptFrom
 *
 * @author KrityCat
 */
public class ReceiptFrom extends HeadReceipt {

    private List<DetailReceipt> details;

    public List<DetailReceipt> getDetails() {
        return details;
    }

    public void setDetails(List<DetailReceipt> details) {
        this.details = details;
    }
}
