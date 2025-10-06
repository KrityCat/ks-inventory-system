package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.Accessory;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.inventory.service.AccessoryService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 配件信息
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/inventory/accessory")
public class AccessoryController extends BaseController {

    @Autowired
    private AccessoryService accessoryService;

    /**
     * 查询接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:list')")
    @GetMapping("/list")
    public TableDataInfo list(Accessory bo) {
        startPage();
        List<Accessory> list = accessoryService.accessoryQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:list')")
    @GetMapping("/recordList")
    public TableDataInfo recordList(Accessory bo) {
        startPage();
        List<Accessory> list = accessoryService.accessoryOperationRecordQuery(bo);
        return getDataTable(list);
    }

    /**
     * 根据配件编号获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:query')")
    @GetMapping(value = {"/", "/{accessoryId}"})
    public AjaxResult getInfo(@PathVariable(value = "accessoryId", required = false) Long accessoryId) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(accessoryId)) {
            Accessory accessory = accessoryService.selectAccessoryById(accessoryId);
            ajax.put(AjaxResult.DATA_TAG, accessory);
        }
        return ajax;
    }

    /**
     * 新增接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:add')")
    @Log(title = "新增配件资料", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody Accessory bo) {
        bo.setCreateBy(getUsername());
        return toAjax(accessoryService.insertAccessory(bo));
    }

    /**
     * 新增接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:add')")
    @Log(title = "新增配件操作", businessType = BusinessType.INSERT)
    @PostMapping("/addRecord")
    public AjaxResult addRecord(@Validated @RequestBody Accessory bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(accessoryService.insertAccessoryRecord(bo));
    }

    /**
     * 修改接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:update')")
    @Log(title = "修改配件资料", businessType = BusinessType.UPDATE)
    @PutMapping("/update")
    public AjaxResult edit(@Validated @RequestBody Accessory bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(accessoryService.updateAccessory(bo));
    }

    /**
     * 删除接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:remove')")
    @Log(title = "删除配件资料", businessType = BusinessType.DELETE)
    @DeleteMapping("/{accessoryIds}")
    public AjaxResult remove(@PathVariable Long[] accessoryIds) {
        return toAjax(accessoryService.deleteAccessoryByIds(accessoryIds));
    }

    /**
     * 导出接口
     */
    @PreAuthorize("@ss.hasPermi('inventory:accessory:export')")
    @Log(title = "导出配件资料", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Accessory bo) {
        List<Accessory> list = accessoryService.accessoryQuery(bo);
        ExcelUtil<Accessory> util = new ExcelUtil<>(Accessory.class);
        util.exportExcel(response, list, "配件资料");
    }
}
