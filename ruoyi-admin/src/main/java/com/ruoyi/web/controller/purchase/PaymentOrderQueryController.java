package com.ruoyi.web.controller.purchase;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailAccountPayment;
import com.ruoyi.common.core.domain.entity.DetailReceiptPayment;
import com.ruoyi.common.core.domain.entity.HeadPayment;
import com.ruoyi.common.core.domain.entity.PaymentFrom;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.inventory.service.PaymentOrderQueryService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 付款头Controller
 *
 * @author kritycat
 */
@RestController
@RequestMapping("/purchase/paymentOrderQuery")
public class PaymentOrderQueryController extends BaseController {
    @Autowired
    private PaymentOrderQueryService paymentOrderQueryService;

    /**
     * 查询付款头表
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:headPaymentQuery')")
    @GetMapping("/headPaymentQuery")
    public TableDataInfo headPaymentQuery(HeadPayment headPayment) {
        startPage();
        List<HeadPayment> list = paymentOrderQueryService.selectHeadPaymentList(headPayment);
        return getDataTable(list);
    }

    /**
     * 查询收付款账号明细列表
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:detailAccountPaymentQuery')")
    @GetMapping("/detailAccountPaymentQuery")
    public TableDataInfo list(DetailAccountPayment detailAccountPayment) {
        startPage();
        List<DetailAccountPayment> list = paymentOrderQueryService.selectDetailAccountPaymentList(detailAccountPayment);
        return getDataTable(list);
    }

    /**
     * 查询收付款单据明细列表
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:detailReceiptPaymentQuery')")
    @GetMapping("/detailReceiptPaymentQuery")
    public TableDataInfo list(DetailReceiptPayment detailReceiptPayment) {
        startPage();
        List<DetailReceiptPayment> list = paymentOrderQueryService.selectDetailReceiptPaymentList(detailReceiptPayment);
        return getDataTable(list);
    }

    /**
     * 获取付款详细信息
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:query')")
    @GetMapping(value = "/{systematicId}")
    public AjaxResult getInfo(@PathVariable("systematicId") Long systematicId) {
        return success(paymentOrderQueryService.selectHeadPaymentBySystematicId(systematicId));
    }


    /**
     * 删除付款单据
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:remove')")
    @Log(title = "删除付款单据", businessType = BusinessType.DELETE)
    @PostMapping("/delete")
    public AjaxResult remove(@PathVariable PaymentFrom paymentFrom) {
        return toAjax(paymentOrderQueryService.deleteHeadPaymentBySystematicIds(paymentFrom));
    }

    /**
     * 导出付款头单据
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:headPaymentExport')")
    @Log(title = "导出付款头单据", businessType = BusinessType.EXPORT)
    @PostMapping("/headPaymentExport")
    public void export(HttpServletResponse response, HeadPayment headPayment) {
        List<HeadPayment> list = paymentOrderQueryService.selectHeadPaymentList(headPayment);
        ExcelUtil<HeadPayment> util = new ExcelUtil<>(HeadPayment.class);
        util.exportExcel(response, list, "付款头数据");
    }

    /**
     * 导出收付款账号明细列表
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:detailAccountPaymentExport')")
    @Log(title = "付款账号明细", businessType = BusinessType.EXPORT)
    @PostMapping("/detailAccountPaymentExport")
    public void export(HttpServletResponse response, DetailAccountPayment detailAccountPayment) {
        List<DetailAccountPayment> list = paymentOrderQueryService.selectDetailAccountPaymentList(detailAccountPayment);
        ExcelUtil<DetailAccountPayment> util = new ExcelUtil<>(DetailAccountPayment.class);
        util.exportExcel(response, list, "付款账号明细数据");
    }

    /**
     * 导出收付款单据明细列表
     */
    @PreAuthorize("@ss.hasPermi('purchase:paymentOrderQuery:detailReceiptPaymentExport')")
    @Log(title = "付款单据明细", businessType = BusinessType.EXPORT)
    @PostMapping("/detailReceiptPaymentExport")
    public void export(HttpServletResponse response, DetailReceiptPayment detailReceiptPayment) {
        List<DetailReceiptPayment> list = paymentOrderQueryService.selectDetailReceiptPaymentList(detailReceiptPayment);
        ExcelUtil<DetailReceiptPayment> util = new ExcelUtil<>(DetailReceiptPayment.class);
        util.exportExcel(response, list, "付款单据明细数据");
    }
}
