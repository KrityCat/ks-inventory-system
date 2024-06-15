package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;

import java.util.List;

public interface SalesMapper {
    /**
     * 销售头单查询
     */
    List<HeadReceipt> SalesHeadReceiptQuery(HeadReceipt bo);

    /**
     * 销售明细查询
     */
    List<DetailReceipt> SalesDetailReceiptQuery(DetailReceipt bo);

    /**
     * 销售详情查询
     */
    HeadReceipt selectSalesOrderById(String systematicReceipt);

}
