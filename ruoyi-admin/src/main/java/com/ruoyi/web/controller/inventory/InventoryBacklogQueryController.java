package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.InventoryProduct;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.inventory.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 库存积压查询模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/inventoryBacklogQuery")
public class InventoryBacklogQueryController extends BaseController {

    @Autowired
    private InventoryService InventoryService;

    /**
     * 积压未入库查询
     */
    @PreAuthorize("@ss.hasPermi('inventory:inventoryBacklogQuery:list')")
    @GetMapping("/list")
    public TableDataInfo list(InventoryProduct bo) {
        startPage();
        List<InventoryProduct> list = InventoryService.selectProductDangerQuery(bo);
        return getDataTable(list);
    }

//    /**
//     * 库存货品导出
//     */
//    @PreAuthorize("@ss.hasPermi('inventory:inventoryBacklogQuery:export')")
//    @Log(title = "库存货品导出", businessType = BusinessType.EXPORT)
//    @PostMapping("/export")
//    public void export(HttpServletResponse response, InventoryProduct bo) {
//        List<InventoryProduct> list = InventoryService.selectInventoryProduct(bo);
//        ExcelUtil<InventoryProduct> util = new ExcelUtil<InventoryProduct>(InventoryProduct.class);
//        util.exportExcel(response, list, "库存货品表");
//    }

}
