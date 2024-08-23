package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.InventoryReceiptQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 库存单据查询模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/inventoryReceiptQuery")
public class InventoryReceiptQueryController extends BaseController {

    @Autowired
    private InventoryReceiptQueryService inventoryReceiptQueryService;

    /**
     * 库存单据头表查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:headQuery')")
    @GetMapping("/headQuery")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = inventoryReceiptQueryService.headReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存单据明细查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:detailQuery')")
    @GetMapping("/detailQuery")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = inventoryReceiptQueryService.detailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 销售金额与毛利润查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:salesAmountQuery')")
    @GetMapping("/salesAmountQuery")
    public HeadReceipt salesAmountQuery(HeadReceipt bo) {
        startPage();
        return inventoryReceiptQueryService.salesAmountQuery(bo);
    }

    /**
     * 库存指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:systematicReceipt')")
    @GetMapping(value = {"/", "/{SystematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "SystematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = inventoryReceiptQueryService.selectHeadReceiptById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 删除库存单据
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:delete')")
    @Log(title = "删除库存单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(inventoryReceiptQueryService.delInventoryReceipt(bo));
    }

    /**
     * 库存单据头表导出
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:headExport')")
    @Log(title = "库存单据头表导出", businessType = BusinessType.EXPORT)
    @PostMapping("/headExport")
    public void export(HttpServletResponse response, HeadReceipt bo) {
        List<HeadReceipt> list = inventoryReceiptQueryService.headReceiptQuery(bo);
        ExcelUtil<HeadReceipt> util = new ExcelUtil<>(HeadReceipt.class);
        util.exportExcel(response, list, "库存单据表");
    }

    /**
     * 库存单据明细导出
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryReceiptQuery:detailExport')")
    @Log(title = "库存单据明细导出", businessType = BusinessType.EXPORT)
    @PostMapping("/detailExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = inventoryReceiptQueryService.detailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<>(DetailReceipt.class);
        util.exportExcel(response, list, "库存单据明细表");
    }

}
