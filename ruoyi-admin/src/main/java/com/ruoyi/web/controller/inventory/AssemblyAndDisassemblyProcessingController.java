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
 * 组装与拆分单据制作模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/assemblyAndDisassemblyProcessing")
public class AssemblyAndDisassemblyProcessingController extends BaseController {

    @Autowired
    private InventoryReceiptProcessingService inventoryReceiptProcessingService;

    /**
     * 组装与拆分指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:assemblyAndDisassemblyProcessing:systematicReceipt')")
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
     * 保存组装与拆分单据信息
     */
    @PreAuthorize("@ss.hasPermi('inventory:assemblyAndDisassemblyProcessing:save')")
    @Log(title = "保存组装与拆分单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(inventoryReceiptProcessingService.saveInventoryReceipt(bo));
    }

    /**
     * 删除组装与拆分单据
     */
    @PreAuthorize("@ss.hasPermi('inventory:assemblyAndDisassemblyProcessing:delete')")
    @Log(title = "删除组装与拆分单据", businessType = BusinessType.DELETE)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody ReceiptFrom bo) {
        return toAjax(inventoryReceiptProcessingService.delInventoryReceipt(bo));
    }

}
