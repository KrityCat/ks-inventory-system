package com.ruoyi.common.core.domain.entity;


import java.util.List;

/**
 * 收付款单据汇总对象 PaymentFrom
 *
 * @author KrityCat
 */
public class PaymentFrom extends HeadPayment {

    private List<DetailAccountPayment> detailAccountPayment;

    private List<DetailReceiptPayment> detailReceiptPayment;

    public List<DetailAccountPayment> getDetailAccountPayment() {
        return detailAccountPayment;
    }

    public void setDetailAccountPayment(List<DetailAccountPayment> detailAccountPayment) {
        this.detailAccountPayment = detailAccountPayment;
    }

    public List<DetailReceiptPayment> getDetailReceiptPayment() {
        return detailReceiptPayment;
    }

    public void setDetailReceiptPayment(List<DetailReceiptPayment> detailReceiptPayment) {
        this.detailReceiptPayment = detailReceiptPayment;
    }

}
