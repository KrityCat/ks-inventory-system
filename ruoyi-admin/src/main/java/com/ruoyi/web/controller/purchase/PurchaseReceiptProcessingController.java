package com.ruoyi.web.controller.purchase;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.PurchaseReceiptProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 采购单据制作模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/purchase/purchaseReceiptProcessing")
public class PurchaseReceiptProcessingController extends BaseController {

    @Autowired
    private PurchaseReceiptProcessingService purchaseReceiptProcessingService;

    /**
     * 查询采购单详情接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptProcessing:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = purchaseReceiptProcessingService.selectPurchaseOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 保存采购入库单据接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptProcessing:save')")
    @Log(title = "保存采购单据", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(purchaseReceiptProcessingService.savePurchaseReceipt(bo));
    }

    /**
     * 删除采购单据接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptProcessing:delete')")
    @Log(title = "删除采购单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(purchaseReceiptProcessingService.delPurchaseReceipt(bo));
    }

}
