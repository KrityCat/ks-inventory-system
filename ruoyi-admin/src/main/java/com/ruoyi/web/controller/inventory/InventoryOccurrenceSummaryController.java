package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 库存发生汇总模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/system/inventoryOccurrenceSummary")
public class InventoryOccurrenceSummaryController extends BaseController {

    @Autowired
    private InventoryService InventoryService;

    /**
     * 货品发生汇总查询
     */
    @PreAuthorize("@ss.hasPermi('system:inventoryOccurrenceSummary:list')")
    @GetMapping("/list")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = InventoryService.inventorySummaryQuery(bo);
        return getDataTable(list);
    }

    /**
     * 货品发生汇总导出
     */
    @PreAuthorize("@ss.hasPermi('system:inventoryOccurrenceSummary:export')")
    @Log(title = "货品发生汇总导出", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = InventoryService.inventorySummaryQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.exportExcel(response, list, "货品发生汇总表");
    }
}
