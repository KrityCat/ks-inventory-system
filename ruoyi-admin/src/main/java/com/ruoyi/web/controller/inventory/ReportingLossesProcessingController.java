package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.inventory.service.InventoryReceiptProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 报损单据制作模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/reportingLossesProcessing")
public class ReportingLossesProcessingController extends BaseController {

    @Autowired
    private InventoryReceiptProcessingService inventoryReceiptProcessingService;

    /**
     * 报损指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:reportingLossesProcessing:systematicReceipt')")
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
     * 保存报损单据信息
     */
    @PreAuthorize("@ss.hasPermi('inventory:reportingLossesProcessing:save')")
    @Log(title = "保存报损单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(inventoryReceiptProcessingService.saveInventoryReceipt(bo));
    }

    /**
     * 删除报损单据
     */
    @PreAuthorize("@ss.hasPermi('inventory:reportingLossesProcessing:delete')")
    @Log(title = "删除报损单据", businessType = BusinessType.DELETE)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody ReceiptFrom bo) {
        return toAjax(inventoryReceiptProcessingService.delInventoryReceipt(bo));
    }

}
