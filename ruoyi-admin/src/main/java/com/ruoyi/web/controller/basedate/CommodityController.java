package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.Commodity;
import com.ruoyi.common.core.domain.entity.CommodityType;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.ICommodityService;
import com.ruoyi.system.service.ICommodityTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 商品资料Controller
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/commodity")
public class CommodityController extends BaseController {

    @Autowired
    private ICommodityService commodityService;

    @Autowired
    private ICommodityTypeService commodityTypeService;

    /**
     * 获取商品类型树列表
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:commodityTypeTree')")
    @GetMapping("/commodityTypeTree")
    public AjaxResult productTypeTree(CommodityType type) {
        List<CommodityType> productTypes = commodityTypeService.selectCommodityTypeList(type);
        return AjaxResult.success(commodityTypeService.buildCommodityTypeTreeSelect(productTypes));
    }

    /**
     * 查询商品资料列表
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:list')")
    @GetMapping("/list")
    public TableDataInfo list(Commodity commodity) {
        startPage();
        List<Commodity> list = commodityService.selectCommodityList(commodity);
        return getDataTable(list);
    }

    /**
     * 模板接口
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Commodity> util = new ExcelUtil<>(Commodity.class);
        util.importTemplateExcel(response, "商品数据");
    }

    /**
     * 导入接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:import')")
    @Log(title = "导入商品资料", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<Commodity> util = new ExcelUtil<>(Commodity.class);
        List<Commodity> commodityList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = commodityService.importCommodity(commodityList, updateSupport, operName);
        return success(message);
    }

    /**
     * 导出商品资料列表
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:export')")
    @Log(title = "商品资料", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Commodity commodity) {
        List<Commodity> list = commodityService.selectCommodityList(commodity);
        ExcelUtil<Commodity> util = new ExcelUtil<Commodity>(Commodity.class);
        util.exportExcel(response, list, "商品资料数据");
    }

    /**
     * 获取商品资料详细信息
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:query')")
    @GetMapping(value = "/{commodityId}")
    public AjaxResult getInfo(@PathVariable("commodityId") Long commodityId) {
        return success(commodityService.selectCommodityByCommodityId(commodityId));
    }

    /**
     * 新增商品资料
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:add')")
    @Log(title = "商品资料", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@RequestBody Commodity commodity) {
        return toAjax(commodityService.insertCommodity(commodity));
    }

    /**
     * 修改商品资料
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:update')")
    @Log(title = "商品资料", businessType = BusinessType.UPDATE)
    @PutMapping("/update")
    public AjaxResult edit(@RequestBody Commodity commodity) {
        return toAjax(commodityService.updateCommodity(commodity));
    }

    /**
     * 删除商品资料
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodity:remove')")
    @Log(title = "商品资料", businessType = BusinessType.DELETE)
    @DeleteMapping("/{commodityIds}")
    public AjaxResult remove(@PathVariable Long[] commodityIds) {
        return toAjax(commodityService.deleteCommodityByCommodityIds(commodityIds));
    }
}
