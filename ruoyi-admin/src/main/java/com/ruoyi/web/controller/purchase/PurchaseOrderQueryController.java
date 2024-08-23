package com.ruoyi.web.controller.purchase;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.PurchaseOrderQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 采购订单查询模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/purchase/purchaseOrderQuery")
public class PurchaseOrderQueryController extends BaseController {

    @Autowired
    private PurchaseOrderQueryService purchaseOrderQueryService;

    /**
     * @param bo 订单信息
     * @return 采购头单查询
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderQuery:headQuery')")
    @GetMapping("/headQuery")
    public TableDataInfo list(HeadOrderForm bo) {
        startPage();
        List<HeadOrderForm> list = purchaseOrderQueryService.purchaseHeadOrderFormQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param bo 订单信息
     * @return 采购明细单查询
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderQuery:detailQuery')")
    @GetMapping("/detailQuery")
    public TableDataInfo list(DetailOrderForm bo) {
        startPage();
        List<DetailOrderForm> list = purchaseOrderQueryService.purchaseDetailOrderFormQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderQuery:systematicOrderForm')")
    @GetMapping(value = {"/", "/{systematicOrderForm}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicOrderForm", required = false) String systematicOrderForm) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicOrderForm)) {
            HeadOrderForm headOrderForm = purchaseOrderQueryService.selectPurchaseOrderFormById(systematicOrderForm);
            ajax.put(AjaxResult.DATA_TAG, headOrderForm);
        }
        return ajax;
    }

    /**
     * 删除采购订单接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderQuery:delete')")
    @Log(title = "删除采购订单", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailOrderForm> bo) {
        return toAjax(purchaseOrderQueryService.delPurchaseOrderForm(bo));
    }

    /**
     * 导出采购订单表接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderQuery:headExport')")
    @Log(title = "导出采购订单表", businessType = BusinessType.EXPORT)
    @PostMapping("/headExport")
    public void export(HttpServletResponse response, HeadOrderForm bo) {
        List<HeadOrderForm> list = purchaseOrderQueryService.purchaseHeadOrderFormQuery(bo);
        ExcelUtil<HeadOrderForm> util = new ExcelUtil<>(HeadOrderForm.class);
        util.exportExcel(response, list, "采购订单表");
    }

    /**
     * 导出采购订单明细表接口
     */
    @PreAuthorize("@ss.hasPermi('purchase:purchaseOrderQuery:detailExport')")
    @Log(title = "导出采购订单明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/detailExport")
    public void export(HttpServletResponse response, DetailOrderForm bo) {
        List<DetailOrderForm> list = purchaseOrderQueryService.purchaseDetailOrderFormQuery(bo);
        ExcelUtil<DetailOrderForm> util = new ExcelUtil<>(DetailOrderForm.class);
        util.exportExcel(response, list, "采购订单明细表");
    }

}
