package com.ruoyi.web.controller.sales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.SalesOrderQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 销售订单模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/sales/salesOrderQuery")
public class SalesOrderQueryController extends BaseController {

    @Autowired
    private SalesOrderQueryService salesOrderQueryService;

    /**
     * @param bo 订单信息
     * @return 销售头单查询
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderQuery:headQuery')")
    @GetMapping("/headQuery")
    public TableDataInfo list(HeadOrderForm bo) {
        startPage();
        List<HeadOrderForm> list = salesOrderQueryService.salesHeadOrderFormQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param bo 订单信息
     * @return 销售明细单查询
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderQuery:detailQuery')")
    @GetMapping("/detailQuery")
    public TableDataInfo list(DetailOrderForm bo) {
        startPage();
        List<DetailOrderForm> list = salesOrderQueryService.salesDetailOrderFormQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderQuery:systematicOrderForm')")
    @GetMapping(value = {"/", "/{systematicOrderForm}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicOrderForm", required = false) String systematicOrderForm) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicOrderForm)) {
            HeadOrderForm headOrderForm = salesOrderQueryService.selectSalesOrderFormById(systematicOrderForm);
            ajax.put(AjaxResult.DATA_TAG, headOrderForm);
        }
        return ajax;
    }

    /**
     * 删除销售订单接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderQuery:delete')")
    @Log(title = "删除销售订单", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailOrderForm> bo) {
        return toAjax(salesOrderQueryService.delSalesOrder(bo));
    }

    /**
     * 导出销售订单表接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderQuery:headExport')")
    @Log(title = "导出销售订单表", businessType = BusinessType.EXPORT)
    @PostMapping("/headExport")
    public void export(HttpServletResponse response, HeadOrderForm bo) {
        List<HeadOrderForm> list = salesOrderQueryService.salesHeadOrderFormQuery(bo);
        ExcelUtil<HeadOrderForm> util = new ExcelUtil<>(HeadOrderForm.class);
        util.exportExcel(response, list, "销售订单表");
    }

    /**
     * 导出销售订单明细表接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderQuery:detailExport')")
    @Log(title = "导出销售订单明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/detailExport")
    public void export(HttpServletResponse response, DetailOrderForm bo) {
        List<DetailOrderForm> list = salesOrderQueryService.salesDetailOrderFormQuery(bo);
        ExcelUtil<DetailOrderForm> util = new ExcelUtil<>(DetailOrderForm.class);
        util.exportExcel(response, list, "销售订单明细表");
    }

}
