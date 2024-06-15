package com.ruoyi.web.controller.sales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.InventoryService;
import com.ruoyi.system.service.SalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 销售模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/system/sales")
public class SalesController extends BaseController {

    @Autowired
    private SalesService SalesService;

    @Autowired
    private InventoryService InventoryService;

    /**
     *
     * @param bo 单据信息
     * @return 销售头单查询
     */
    @PreAuthorize("@ss.hasPermi('system:sales:salesHeadQuery')")
    @GetMapping("/SalesHeadQuery")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = SalesService.SalesHeadReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     *
     * @param bo 单据信息
     * @return 销售明细单查询
     */
    @PreAuthorize("@ss.hasPermi('system:sales:salesDetailQuery')")
    @GetMapping("/SalesDetailQuery")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = SalesService.SalesDetailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     *
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @PreAuthorize("@ss.hasPermi('system:sales:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = SalesService.selectSalesOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     *
     * @param bo 单据信息
     * @return 保存销售出库单据信息
     */
    @PreAuthorize("@ss.hasPermi('system:sales:saveSalesOutbound')")
    @Log(title = "保存销售出库单据", businessType = BusinessType.INSERT)
    @PostMapping("/saveSalesOutbound")
    public AjaxResult saveSalesOutbound(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(SalesService.saveSalesOutbound(bo));
    }

    /**
     *
     * @param bo 单据信息
     * @return 保存销售退库单据信息
     */
    @PreAuthorize("@ss.hasPermi('system:sales:saveSalesRetreat')")
    @Log(title = "保存销售退库单据", businessType = BusinessType.INSERT)
    @PostMapping("/saveSalesRetreat")
    public AjaxResult saveSalesRetreat(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(SalesService.saveSalesRetreat(bo));
    }

    /**
     * 删除销售单据接口
     */
    @PreAuthorize("@ss.hasPermi('system:sales:delete')")
    @Log(title = "删除销售单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(InventoryService.delInventoryReceipt(bo));
    }

    /**
     * 导出销售单据表接口
     */
    @PreAuthorize("@ss.hasPermi('system:sales:salesHeadExport')")
    @Log(title = "导出销售单据表", businessType = BusinessType.EXPORT)
    @PostMapping("/salesHeadExport")
    public void export(HttpServletResponse response, HeadReceipt bo) {
        List<HeadReceipt> list = SalesService.SalesHeadReceiptQuery(bo);
        ExcelUtil<HeadReceipt> util = new ExcelUtil<HeadReceipt>(HeadReceipt.class);
        util.exportExcel(response, list, "销售单据表");
    }

    /**
     * 导出销售单据明细表接口
     */
    @PreAuthorize("@ss.hasPermi('system:sales:salesDetailExport')")
    @Log(title = "导出销售单据明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/salesDetailExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = SalesService.SalesDetailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.exportExcel(response, list, "销售单据明细表");
    }

}
