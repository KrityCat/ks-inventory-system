package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.Supplier;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 供应商资料
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/supplier")
public class SupplierController extends BaseController {

    @Autowired
    private SupplierService SlService;

    /**
     * 查询供应商接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:list')")
    @GetMapping("/list")
    public TableDataInfo list(Supplier bo) {
        startPage();
        List<Supplier> list = SlService.SupplierQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询供应商详情接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:query')")
    @GetMapping(value = {"/", "/{supplierId}"})
    public AjaxResult getInfo(@PathVariable(value = "supplierId", required = false) Long supplierId) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(supplierId)) {
            Supplier supplier = SlService.selectSupplierById(supplierId);
            ajax.put(AjaxResult.DATA_TAG, supplier);
        }
        return ajax;
    }

    /**
     * 新增接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:add')")
    @Log(title = "新增供应商资料", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody Supplier bo) {
        bo.setCreateBy(getUsername());
        return toAjax(SlService.insertSupplier(bo));
    }

    /**
     * 修改接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:update')")
    @Log(title = "修改供应商资料", businessType = BusinessType.INSERT)
    @PutMapping("/update")
    public AjaxResult edit(@Validated @RequestBody Supplier bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(SlService.updateSupplier(bo));
    }

    /**
     * 删除接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:remove')")
    @Log(title = "删除供应商资料", businessType = BusinessType.INSERT)
    @DeleteMapping("/{supplierIds}")
    public AjaxResult remove(@PathVariable Long[] supplierIds) {
        return toAjax(SlService.deleteSupplierByIds(supplierIds));
    }

    /**
     * 模板接口
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Supplier> util = new ExcelUtil<Supplier>(Supplier.class);
        util.importTemplateExcel(response, "供应商数据");
    }

    /**
     * 导入接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:import')")
    @Log(title = "导入供应商资料", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<Supplier> util = new ExcelUtil<Supplier>(Supplier.class);
        List<Supplier> SupplierList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = SlService.importSupplier(SupplierList, updateSupport, operName);
        return success(message);
    }

    /**
     * 供应商接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:supplier:export')")
    @Log(title = "导出供应商资料", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Supplier bo) {
        List<Supplier> list = SlService.SupplierQuery(bo);
        ExcelUtil<Supplier> util = new ExcelUtil<Supplier>(Supplier.class);
        util.exportExcel(response, list, "供应商数据");
    }
}
