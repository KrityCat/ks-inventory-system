package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;

import java.util.List;

public interface HeadReceiptMapper {
    /**
     * 库存头单查询
     */
    List<HeadReceipt> headReceiptQuery(HeadReceipt bo);

    /**
     * 销售金额与毛利润查询
     */
    HeadReceipt salesAmountQuery(HeadReceipt bo);

    /**
     * 单据编号查询
     */
    HeadReceipt selectHeadReceiptById(String systematicReceipt);

    /**
     * 单据编号查询
     */
    List<HeadReceipt> selectHeadReceiptByCount(HeadReceipt bo);

    /**
     * 单据头表新增
     */
    int addHeadReceipt(HeadReceipt bo);

    /**
     * 单据头表修改
     */
    int updateHeadReceipt(HeadReceipt bo);

    /**
     * 单据头表删除
     */
    int delHeadReceipt(List<DetailReceipt> bo);

}
