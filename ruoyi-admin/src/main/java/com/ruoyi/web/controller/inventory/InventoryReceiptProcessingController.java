package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.InventoryReceiptProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 库存单据制作模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/inventoryReceiptProcessing")
public class InventoryReceiptProcessingController extends BaseController {

    @Autowired
    private InventoryReceiptProcessingService inventoryReceiptProcessingService;

    /**
     * 库存指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptProcessing:systematicReceipt')")
    @GetMapping(value = {"/", "/{SystematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "SystematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = inventoryReceiptProcessingService.selectHeadReceiptById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 保存库存单据信息
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptProcessing:save')")
    @Log(title = "保存其他入库单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(inventoryReceiptProcessingService.saveInventoryReceipt(bo));
    }

    /**
     * 保存库存调拨单据信息
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryTransferProcessing:save')")
    @Log(title = "保存库存调拨单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/saveInventoryTransfer")
    public AjaxResult saveInventoryTransfer(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(inventoryReceiptProcessingService.saveInventoryReceipt(bo));
    }

    /**
     * 保存库存盘点单据信息
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryCountingProcessing:save')")
    @Log(title = "保存库存盘点单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/saveInventoryCounting")
    public AjaxResult saveInventoryCounting(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(inventoryReceiptProcessingService.saveInventoryReceipt(bo));
    }

    /**
     * 删除库存单据
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptProcessing:delete')")
    @Log(title = "删除库存单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(inventoryReceiptProcessingService.delInventoryReceipt(bo));
    }

}
