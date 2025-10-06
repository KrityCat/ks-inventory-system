package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.Warehouse;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.inventory.service.WarehouseService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 仓库资料
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/warehouse")
public class WarehouseController extends BaseController {

    @Autowired
    private WarehouseService warehouseService;

    /**
     * 查询接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:list')")
    @GetMapping("/list")
    public TableDataInfo list(Warehouse bo) {
        startPage();
        List<Warehouse> list = warehouseService.WarehouseQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询仓库详情接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:query')")
    @GetMapping(value = {"/", "/{warehouseId}"})
    public AjaxResult getInfo(@PathVariable(value = "warehouseId", required = false) Long warehouseId) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(warehouseId)) {
            Warehouse warehouse = warehouseService.selectWarehouseById(warehouseId);
            ajax.put(AjaxResult.DATA_TAG, warehouse);
        }
        return ajax;
    }

    /**
     * 新增接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:add')")
    @Log(title = "新增仓库资料", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody Warehouse bo) {
        bo.setCreateBy(getUsername());
        return toAjax(warehouseService.insertWarehouse(bo));
    }

    /**
     * 修改接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:update')")
    @Log(title = "修改仓库资料", businessType = BusinessType.INSERT)
    @PutMapping("/update")
    public AjaxResult edit(@Validated @RequestBody Warehouse bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(warehouseService.updateWarehouse(bo));
    }

    /**
     * 删除接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:remove')")
    @Log(title = "删除仓库资料", businessType = BusinessType.INSERT)
    @DeleteMapping("/{warehouseIds}")
    public AjaxResult remove(@PathVariable Long[] warehouseIds) {
        return toAjax(warehouseService.deleteWarehouseByIds(warehouseIds));
    }

    /**
     * 模板接口
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Warehouse> util = new ExcelUtil<Warehouse>(Warehouse.class);
        util.importTemplateExcel(response, "仓库数据");
    }

    /**
     * 导入接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:import')")
    @Log(title = "导入仓库资料", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<Warehouse> util = new ExcelUtil<Warehouse>(Warehouse.class);
        List<Warehouse> warehousesList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = warehouseService.importWarehouse(warehousesList, updateSupport, operName);
        return success(message);
    }

    /**
     * 导出接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:warehouse:export')")
    @Log(title = "导出仓库资料", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Warehouse bo) {
        List<Warehouse> list = warehouseService.WarehouseQuery(bo);
        ExcelUtil<Warehouse> util = new ExcelUtil<Warehouse>(Warehouse.class);
        util.exportExcel(response, list, "仓库数据");
    }
}
