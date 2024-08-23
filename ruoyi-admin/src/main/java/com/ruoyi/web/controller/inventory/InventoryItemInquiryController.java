package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.InventoryProduct;
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
 * 库存货品查询模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/inventoryItemInquiry")
public class InventoryItemInquiryController extends BaseController {

    @Autowired
    private InventoryService InventoryService;

    /**
     * 库存货品查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryItemInquiry:list')")
    @GetMapping("/list")
    public TableDataInfo list(InventoryProduct bo) {
        startPage();
        List<InventoryProduct> list = InventoryService.selectInventoryProduct(bo);
        return getDataTable(list);
    }

    /**
     * 库存货品导出
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryItemInquiry:export')")
    @Log(title = "库存货品导出", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, InventoryProduct bo) {
        List<InventoryProduct> list = InventoryService.selectInventoryProduct(bo);
        ExcelUtil<InventoryProduct> util = new ExcelUtil<InventoryProduct>(InventoryProduct.class);
        util.exportExcel(response, list, "库存货品表");
    }

}
