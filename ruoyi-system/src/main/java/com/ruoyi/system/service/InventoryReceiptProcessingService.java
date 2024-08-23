package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;

import java.util.List;

/**
 * 库存单据 业务层
 *
 * @author KrityCat
 */
public interface InventoryReceiptProcessingService {

    /**
     * @param systematicReceipt 系统单号
     * @return 库存指定单据查询
     */
    HeadReceipt selectHeadReceiptById(String systematicReceipt);

    /**
     * @param bo 单据信息
     * @return 保存库存单据信息
     */
    int saveInventoryReceipt(ReceiptFrom bo);

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    int delInventoryReceipt(List<DetailReceipt> bo);
}
