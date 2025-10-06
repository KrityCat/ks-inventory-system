package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.InventorySummary;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.inventory.service.InventoryService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 库存发生汇总模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/inventoryOccurrenceSummary")
public class InventoryOccurrenceSummaryController extends BaseController {

    @Autowired
    private InventoryService InventoryService;

    /**
     * 货品发生汇总查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryOccurrenceSummary:list')")
    @GetMapping("/list")
    public TableDataInfo list(InventorySummary bo) {
        startPage();
        List<InventorySummary> list = InventoryService.inventorySummaryQuery(bo);
        return getDataTable(list);
    }

    /**
     * 货品发生汇总导出
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryOccurrenceSummary:export')")
    @Log(title = "货品发生汇总导出", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, InventorySummary bo) {
        List<InventorySummary> list = InventoryService.inventorySummaryQuery(bo);
        ExcelUtil<InventorySummary> util = new ExcelUtil<>(InventorySummary.class);
        util.exportExcel(response, list, "货品发生汇总表");
    }
}
