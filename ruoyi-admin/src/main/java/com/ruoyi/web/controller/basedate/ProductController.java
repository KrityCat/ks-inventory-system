package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.Product;
import com.ruoyi.common.core.domain.entity.ProductType;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.ISysPostService;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.ProductService;
import com.ruoyi.system.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 货品信息
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/product")
public class ProductController extends BaseController {

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ProductService PdService;

    @Autowired
    private ProductTypeService typeService;

    @Autowired
    private ISysPostService postService;

    /**
     * 获取货品类型树列表
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:productTypeTree')")
    @GetMapping("/productTypeTree")
    public AjaxResult productTypeTree(ProductType type) {
        List<ProductType> productTypes = typeService.selectProductTypeList(type);
        return AjaxResult.success(typeService.buildProductTypeTreeSelect(productTypes));
    }

    /**
     * 查询接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:list')")
    @GetMapping("/list")
    public TableDataInfo list(Product bo) {
        startPage();
        List<Product> list = PdService.ProductQuery(bo);
        return getDataTable(list);
    }

    /**
     * 根据货品编号获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:query')")
    @GetMapping(value = {"/", "/{productId}"})
    public AjaxResult getInfo(@PathVariable(value = "productId", required = false) Long productId) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(productId)) {
            Product product = PdService.selectProductById(productId);
            ajax.put(AjaxResult.DATA_TAG, product);
        }
        return ajax;
    }

    /**
     * 新增接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:add')")
    @Log(title = "新增货品资料", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody Product bo) {
        bo.setCreateBy(getUsername());
        return toAjax(PdService.insertProduct(bo));
    }

    /**
     * 修改接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:update')")
    @Log(title = "修改货品资料", businessType = BusinessType.INSERT)
    @PutMapping("/update")
    public AjaxResult edit(@Validated @RequestBody Product bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(PdService.updateProduct(bo));
    }

    /**
     * 删除接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:remove')")
    @Log(title = "删除货品资料", businessType = BusinessType.INSERT)
    @DeleteMapping("/{productIds}")
    public AjaxResult remove(@PathVariable Long[] productIds) {
        return toAjax(PdService.deleteProductByIds(productIds));
    }

    /**
     * 模板接口
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Product> util = new ExcelUtil<Product>(Product.class);
        util.importTemplateExcel(response, "货品数据");
    }

    /**
     * 导入接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:import')")
    @Log(title = "导入货品资料", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<Product> util = new ExcelUtil<Product>(Product.class);
        List<Product> productList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = PdService.importProduct(productList, updateSupport, operName);
        return success(message);
    }

    /**
     * 导出接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:product:export')")
    @Log(title = "导出货品资料", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Product bo) {
        List<Product> list = PdService.ProductQuery(bo);
        ExcelUtil<Product> util = new ExcelUtil<Product>(Product.class);
        util.exportExcel(response, list, "货品数据");
    }
}
