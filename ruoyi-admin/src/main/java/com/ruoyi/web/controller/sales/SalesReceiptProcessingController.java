package com.ruoyi.web.controller.sales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.SalesReceiptProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 销售单据制作模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/sales/salesReceiptProcessing")
public class SalesReceiptProcessingController extends BaseController {

    @Autowired
    private SalesReceiptProcessingService salesReceiptProcessingService;

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptProcessing:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = salesReceiptProcessingService.selectSalesOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * @param bo 单据信息
     * @return 保存销售单据信息
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptProcessing:save')")
    @Log(title = "保存销售出库单据", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ReceiptFrom bo) {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(salesReceiptProcessingService.saveSalesReceipt(bo));
    }

    /**
     * 删除销售单据接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptProcessing:delete')")
    @Log(title = "删除销售单据", businessType = BusinessType.DELETE)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(salesReceiptProcessingService.delSalesReceipt(bo));
    }
}
