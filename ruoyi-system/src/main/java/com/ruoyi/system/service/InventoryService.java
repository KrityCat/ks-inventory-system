package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.InventoryProduct;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;

import java.util.List;

/**
 * 库存单据 业务层
 *
 * @author KrityCat
 */
public interface InventoryService {

    /**
     *
     * @param bo 单据信息
     * @return 库存货品查询
     */
    List<InventoryProduct> selectInventoryProduct(InventoryProduct bo);

    /**
     *
     * @param bo 单据信息
     * @return 库存单据头表查询
     */
    List<HeadReceipt> headReceiptQuery(HeadReceipt bo);

    /**
     *
     * @param bo 单据信息
     * @return 库存单据明细查询
     */
    List<DetailReceipt> detailReceiptQuery(DetailReceipt bo);

    /**
     *
     * @param bo 单据信息
     * @return 货品发生汇总查询
     */
    List<DetailReceipt> inventorySummaryQuery(DetailReceipt bo);

    /**
     *
     * @param bo 单据信息
     * @return 货品发生明细查询
     */
    List<DetailReceipt> inventoryDetailsQuery(DetailReceipt bo);

    /**
     *
     * @param SystematicReceipt 系统单号
     * @return 库存指定单据查询
     */
    HeadReceipt selectHeadReceiptById(String SystematicReceipt);

    /**
     *
     * @param bo 单据信息
     * @return 保存其他入库单据信息
     */
    int saveStorageOther(ReceiptFrom bo);

    /**
     *
     * @param bo 单据信息
     * @return 保存其他出库单据信息
     */
    int saveOutboundOther(ReceiptFrom bo);

    /**
     *
     * @param bo 单据信息
     * @return 保存库存调拨单据信息
     */
    int saveInventoryTransfer(ReceiptFrom bo);

    /**
     *
     * @param bo 单据信息
     * @return 保存库存盘点单据信息
     */
    int saveInventoryCounting(ReceiptFrom bo);

    /**
     *
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    int delInventoryReceipt(List<DetailReceipt> bo);

    /**
     *
     * @param HeadDataList 单据信息
     * @return 导入单据头表
     */
    String importHeadData(List<HeadReceipt> HeadDataList, Boolean isUpdateSupport, String operName);

    /**
     *
     * @param DetailDataList 单据信息
     * @return 导入单据明细表
     */
    String importDetailData(List<DetailReceipt> DetailDataList, Boolean isUpdateSupport, String operName);

}
