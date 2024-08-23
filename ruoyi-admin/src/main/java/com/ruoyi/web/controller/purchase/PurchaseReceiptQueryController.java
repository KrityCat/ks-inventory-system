package com.ruoyi.web.controller.purchase;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.PurchaseReceiptQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 采购单据查询模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/purchase/purchaseReceiptQuery")
public class PurchaseReceiptQueryController extends BaseController {

    @Autowired
    private PurchaseReceiptQueryService purchaseReceiptQueryService;

    /**
     * @param bo 单据信息
     * @return 采购头单查询
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptQuery:headQuery')")
    @GetMapping("/headQuery")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = purchaseReceiptQueryService.purchaseHeadReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询采购明细单接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptQuery:detailQuery')")
    @GetMapping("/detailQuery")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = purchaseReceiptQueryService.purchaseDetailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询采购单详情接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptQuery:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = purchaseReceiptQueryService.selectPurchaseOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 删除采购单据接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptQuery:delete')")
    @Log(title = "删除采购单", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(purchaseReceiptQueryService.delPurchaseReceipt(bo));
    }

    /**
     * 导出头表接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptQuery:headExport')")
    @Log(title = "导出采购单据头表", businessType = BusinessType.EXPORT)
    @PostMapping("/headExport")
    public void export(HttpServletResponse response, HeadReceipt bo) {
        List<HeadReceipt> list = purchaseReceiptQueryService.purchaseHeadReceiptQuery(bo);
        ExcelUtil<HeadReceipt> util = new ExcelUtil<>(HeadReceipt.class);
        util.exportExcel(response, list, "采购单据表");
    }

    /**
     * 导出明细表接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseReceiptQuery:detailExport')")
    @Log(title = "导出采购单据明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/detailExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = purchaseReceiptQueryService.purchaseDetailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<>(DetailReceipt.class);
        util.exportExcel(response, list, "采购单据明细表");
    }

}
