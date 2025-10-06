package com.ruoyi.inventory.utils;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.inventory.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 单据公共方法 业务层处理
 *
 * @author KrityCat
 */
@Component
public class CommonReceipt {

    // region 常量定义
    // 入库类型集合（1、4、5、8、10表示不同类型的入库单据）
    private static final List<Long> INBOUND_TYPES = Arrays.asList(1L, 4L, 5L, 7L, 8L, 10L);

    // 出库类型集合（2、3、6、7、9表示不同类型的出库单据）
    private static final List<Long> OUTBOUND_TYPES = Arrays.asList(2L, 3L, 6L, 7L, 9L);

    private final InventoryMapper inventoryMapper;

    private final HeadReceiptMapper headReceiptMapper;

    private final DetailReceiptMapper detailReceiptMapper;

    private final HeadReceiptLogMapper headReceiptLogMapper;

    private final DetailReceiptLogMapper detailReceiptLogMapper;

    // 构造器注入
    @Autowired
    public CommonReceipt(
            HeadReceiptMapper headReceiptMapper,
            DetailReceiptMapper detailReceiptMapper,
            InventoryMapper inventoryMapper,
            HeadReceiptLogMapper headReceiptLogMapper,
            DetailReceiptLogMapper detailReceiptLogMapper
    ) {
        this.headReceiptMapper = headReceiptMapper;
        this.detailReceiptMapper = detailReceiptMapper;
        this.inventoryMapper = inventoryMapper;
        this.headReceiptLogMapper = headReceiptLogMapper;
        this.detailReceiptLogMapper = detailReceiptLogMapper;
    }

    private boolean isInbound(ReceiptFrom bo) {
        long receiptType = bo.getReceiptType();
        return INBOUND_TYPES.contains(receiptType);
    }

    private boolean isOutbound(ReceiptFrom bo) {
        long receiptType = bo.getReceiptType();
        return OUTBOUND_TYPES.contains(receiptType);
    }

    /**
     * 参数校验
     *
     * @param bo 待校验的单据对象
     * @throws IllegalArgumentException 如果参数不合法
     */
    public void validateParams(ReceiptFrom bo) {
        Assert.notNull(bo, "单据参数不能为空");
        Assert.notEmpty(bo.getDetails(), "单据明细不能为空");
    }

    /**
     * 判断是否为新单据
     *
     * @param bo 单据对象
     * @return true-新单据，false-已存在单据
     */
    public boolean isNewReceipt(ReceiptFrom bo) {
        return headReceiptMapper.selectHeadReceiptByCount(bo).isEmpty();
    }

    /**
     * 判断是否为新库存
     *
     * @param detail 库存对象
     * @return true-新库存，false-已存在库存
     */
    public boolean isNewInventory(DetailReceipt detail) {
        return inventoryMapper.selectInventoryById(detail) == null;
    }

    /**
     * 处理新单据创建
     *
     * @param bo 单据头信息
     */
    @Transactional(rollbackFor = Exception.class)
    public void handleNewReceipt(ReceiptFrom bo) {
        List<DetailReceipt> details = bo.getDetails();
        for (DetailReceipt detail : bo.getDetails()) {
            detail.setCreateBy(bo.getCreateBy());
        }
        // 新增头数据
        headReceiptMapper.addHeadReceipt(bo);
        // 新增明细数据
        detailReceiptMapper.addDetailReceipt(details);
        // 新增头操作记录数据
        headReceiptLogMapper.addHeadReceiptLog(bo);
        // 新增明细操作记录数据
        detailReceiptLogMapper.addDetailReceiptLog(details);
    }

    /**
     * 处理已有单据的更新
     *
     * @param bo 单据头信息
     */
    @Transactional(rollbackFor = Exception.class)
    public void handleExistingReceipt(ReceiptFrom bo) {
//        List<DetailReceipt> oldDetails = headReceiptMapper.selectHeadReceiptById(bo.getSystematicReceipt()).getDetails();
        List<DetailReceipt> newDetails = bo.getDetails();

        for (DetailReceipt detail : bo.getDetails()) {
            detail.setUpdateBy(bo.getUpdateBy());
        }

        // 拆分新增和更新仓库和货品维度列表
        List<DetailReceipt> newInventoryList = new ArrayList<>();
        List<DetailReceipt> existingInventoryList = new ArrayList<>();

        for (DetailReceipt detail : newDetails) {
            if (isNewInventory(detail)) {
                newInventoryList.add(detail);
            } else {
                existingInventoryList.add(detail);
            }
        }

        headReceiptMapper.updateHeadReceipt(bo);
        detailReceiptMapper.delDetailReceipt(newDetails);
        detailReceiptMapper.addDetailReceipt(newDetails);
        // 新增头操作记录数据
        headReceiptLogMapper.addHeadReceiptLog(bo);
        // 新增明细操作记录数据
        detailReceiptLogMapper.addDetailReceiptLog(newDetails);

        // 处理新增库存
        if (!newInventoryList.isEmpty()) {
            if (isInbound(bo)) {
                inventoryMapper.addInInventory(newInventoryList);
            }
            if (isOutbound(bo)) {
                throw new ServiceException("货品库存为0，请先添加库存");
            }
        }

        // 处理更新库存
        if (!existingInventoryList.isEmpty()) {
            if (isInbound(bo)) {
                inventoryMapper.updateInInventory(existingInventoryList);
            }
            if (isOutbound(bo)) {
                inventoryMapper.updateOutInventory(existingInventoryList);
            }
        }

    }

    /**
     * 处理已有单据的删除
     *
     * @param bo 单据头信息
     */
    @Transactional(rollbackFor = Exception.class)
    public void handDelReceipt(ReceiptFrom bo) {
        List<DetailReceipt> details = bo.getDetails();
        // 删除头数据
        detailReceiptMapper.delDetailReceipt(details);
        // 删除明细数据
        headReceiptMapper.delHeadReceipt(details);
        // 删除头操作记录数据
        headReceiptLogMapper.delHeadReceiptLog(details);
        // 删除明细操作记录数据
        detailReceiptLogMapper.delDetailReceiptLog(details);
        // 处理更新库存
        if (isInbound(bo)) {
            inventoryMapper.updateInInventory(details);
        }
        if (isOutbound(bo)) {
            inventoryMapper.updateOutInventory(details);
        }
    }


}
