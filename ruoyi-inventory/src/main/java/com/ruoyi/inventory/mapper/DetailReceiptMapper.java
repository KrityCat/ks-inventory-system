package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;

import java.util.List;

public interface DetailReceiptMapper {

    /**
     * 库存明细表查询
     */
    List<DetailReceipt> SelectDetailReceiptQuery(DetailReceipt bo);

    /**
     * 入库锁单数量查询
     */
    List<DetailReceipt> selectLockInventoryQtyByReceipt(DetailReceipt bo);

    /**
     * 单据锁单数量查询
     */
    List<DetailReceipt> selectLockQtyByReceipt(DetailReceipt bo);
    
    /**
     * 货品发生明细表查询
     */
    List<DetailReceipt> inventoryDetailsQuery(DetailReceipt bo);

    /**
     * 单据明细表新增
     */
    int addDetailReceipt(List<DetailReceipt> bo);

    /**
     * 单据明细表修改
     */
    int updateDetailReceipt(List<DetailReceipt> bo);

    /**
     * 单据明细表删除
     */
    int delDetailReceipt(List<DetailReceipt> bo);

}
