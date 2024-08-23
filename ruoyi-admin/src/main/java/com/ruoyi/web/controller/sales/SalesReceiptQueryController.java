package com.ruoyi.web.controller.sales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.SalesReceiptQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 销售单据制作模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/sales/salesReceiptQuery")
public class SalesReceiptQueryController extends BaseController {

    @Autowired
    private SalesReceiptQueryService salesReceiptQueryService;

    /**
     * @param bo 单据信息
     * @return 销售头单查询
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptQuery:headQuery')")
    @GetMapping("/headQuery")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = salesReceiptQueryService.SalesHeadReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param bo 单据信息
     * @return 销售明细单查询
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptQuery:detailQuery')")
    @GetMapping("/detailQuery")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = salesReceiptQueryService.SalesDetailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptQuery:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = salesReceiptQueryService.selectSalesOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 删除销售单据接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptQuery:delete')")
    @Log(title = "删除销售单据", businessType = BusinessType.DELETE)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(salesReceiptQueryService.delSalesReceipt(bo));
    }

    /**
     * 导出销售单据表接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptQuery:headExport')")
    @Log(title = "导出销售单据表", businessType = BusinessType.EXPORT)
    @PostMapping("/headExport")
    public void export(HttpServletResponse response, HeadReceipt bo) {
        List<HeadReceipt> list = salesReceiptQueryService.SalesHeadReceiptQuery(bo);
        ExcelUtil<HeadReceipt> util = new ExcelUtil<HeadReceipt>(HeadReceipt.class);
        util.exportExcel(response, list, "销售单据表");
    }

    /**
     * 导出销售单据明细表接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesReceiptQuery:detailExport')")
    @Log(title = "导出销售单据明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/detailExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = salesReceiptQueryService.SalesDetailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.exportExcel(response, list, "销售单据明细表");
    }

}
