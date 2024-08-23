package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.ProductType;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.ProductTypeService;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 货品类型
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/productType")
public class ProductTypeController extends BaseController {
    @Autowired
    private ProductTypeService productTypeService;

    /**
     * 获取货品类型列表
     */
    @PreAuthorize("@ss.hasPermi('baseDate:productType:list')")
    @GetMapping("/list")
    public AjaxResult list(ProductType type) {
        List<ProductType> types = productTypeService.selectProductTypeList(type);
        return success(types);
    }

    /**
     * 查询货品类型列表（排除节点）
     */
    @PreAuthorize("@ss.hasPermi('baseDate:productType:list')")
    @GetMapping("/list/exclude/{productId}")
    public AjaxResult excludeChild(@PathVariable(value = "productId", required = false) Long productId) {
        List<ProductType> types = productTypeService.selectProductTypeList(new ProductType());
        types.removeIf(d -> d.getProductTypeId().intValue() == productId || ArrayUtils.contains(StringUtils.split(d.getAncestors(), ","), productId + ""));
        return success(types);
    }

    /**
     * 根据货品类型编号获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('baseDate:productType:query')")
    @GetMapping(value = "/{productTypeId}")
    public AjaxResult getInfo(@PathVariable Long productTypeId) {
        return success(productTypeService.selectTypeById(productTypeId));
    }

    /**
     * 新增货品类型
     */
    @PreAuthorize("@ss.hasPermi('baseDate:productType:add')")
    @Log(title = "新增货品类型", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody ProductType productType) {
        if (!productTypeService.checkTypeNameUnique(productType)) {
            return error("新增货品类型'" + productType.getProductTypeName() + "'失败，货品类型已存在");
        }
        productType.setCreateBy(getUsername());
        return toAjax(productTypeService.insertType(productType));
    }

    /**
     * 修改货品类型
     */
    @PreAuthorize("@ss.hasPermi('baseDate:productType:edit')")
    @Log(title = "修改货品类型", businessType = BusinessType.UPDATE)
    @PutMapping("/edit")
    public AjaxResult edit(@Validated @RequestBody ProductType type) {
        Long productId = type.getProductTypeId();
        if (!productTypeService.checkTypeNameUnique(type)) {
            return error("修改货品类型'" + type.getProductTypeName() + "'失败，货品类型已存在");
        } else if (type.getParentId().equals(productId)) {
            return error("修改货品类型'" + type.getProductTypeName() + "'失败，上级货品类型不能是自己");
        } else if (StringUtils.equals(UserConstants.DEPT_DISABLE, type.getStatus()) && productTypeService.selectNormalChildrenTypeById(productId) > 0) {
            return error("该货品类型包含未停用的子货品类型！");
        }
        type.setUpdateBy(getUsername());
        return toAjax(productTypeService.updateType(type));
    }

    /**
     * 删除货品类型
     */
    @PreAuthorize("@ss.hasPermi('baseDate:productType:remove')")
    @Log(title = "货品类型管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{productId}")
    public AjaxResult remove(@PathVariable Long productId) {
        if (productTypeService.hasChildByProductId(productId)) {
            return warn("存在下级货品类型,不允许删除");
        }
        return toAjax(productTypeService.deleteTypeById(productId));
    }
}
