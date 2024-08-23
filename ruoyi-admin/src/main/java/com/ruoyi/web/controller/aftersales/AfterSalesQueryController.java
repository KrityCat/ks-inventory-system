package com.ruoyi.web.controller.aftersales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.AfterSalesQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 售后模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/afterSales/afterSalesQuery")
public class AfterSalesQueryController extends BaseController {

    @Autowired
    private AfterSalesQueryService afterSalesQueryService;

    /**
     * @param bo 单据信息
     * @return 售后头单查询
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderQuery:headQuery')")
    @GetMapping("/headQuery")
    public TableDataInfo list(HeadService bo) {
        startPage();
        List<HeadService> list = afterSalesQueryService.salesHeadServiceQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param bo 单据信息
     * @return 售后明细单查询
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderQuery:detailQuery')")
    @GetMapping("/detailQuery")
    public TableDataInfo list(DetailService bo) {
        startPage();
        List<DetailService> list = afterSalesQueryService.salesDetailServiceQuery(bo);
        return getDataTable(list);
    }

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderQuery:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadService headService = afterSalesQueryService.selectSalesOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headService);
        }
        return ajax;
    }

    /**
     * 删除售后单据接口
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderQuery:delete')")
    @Log(title = "删除售后单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailService> bo) {
        return toAjax(afterSalesQueryService.delAfterSales(bo));
    }

    /**
     * 导出售后单据表接口
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderQuery:headExport')")
    @Log(title = "导出售后单据表", businessType = BusinessType.EXPORT)
    @PostMapping("/headExport")
    public void export(HttpServletResponse response, HeadService bo) {
        List<HeadService> list = afterSalesQueryService.salesHeadServiceQuery(bo);
        ExcelUtil<HeadService> util = new ExcelUtil<>(HeadService.class);
        util.exportExcel(response, list, "售后单据表");
    }

    /**
     * 导出售后单据明细表接口
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderQuery:detailExport')")
    @Log(title = "导出售后单据明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/detailExport")
    public void export(HttpServletResponse response, DetailService bo) {
        List<DetailService> list = afterSalesQueryService.salesDetailServiceQuery(bo);
        ExcelUtil<DetailService> util = new ExcelUtil<>(DetailService.class);
        util.exportExcel(response, list, "售后单据明细表");
    }

}
