package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.CommodityType;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.ICommodityTypeService;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 商品类型Controller
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/commodityType")
public class CommodityTypeController extends BaseController {
    @Autowired
    private ICommodityTypeService commodityTypeService;

    /**
     * 查询商品类型列表
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodityType:list')")
    @GetMapping("/list")
    public AjaxResult list(CommodityType commodityType) {
        List<CommodityType> list = commodityTypeService.selectCommodityTypeList(commodityType);
        return success(list);
    }

    /**
     * 查询商品类型列表（排除节点）
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodityType:list')")
    @GetMapping("/list/exclude/{commodityTypeId}")
    public AjaxResult excludeChild(@PathVariable(value = "commodityTypeId", required = false) Long commodityId) {
        List<CommodityType> types = commodityTypeService.selectCommodityTypeList(new CommodityType());
        types.removeIf(d -> d.getCommodityTypeId().intValue() == commodityId || ArrayUtils.contains(StringUtils.split(d.getAncestors(), ","), commodityId + ""));
        return success(types);
    }

    /**
     * 根据商品类型编号获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodityType:query')")
    @GetMapping(value = "/{commodityTypeId}")
    public AjaxResult getInfo(@PathVariable("commodityTypeId") Long commodityTypeId) {
        return success(commodityTypeService.selectTypeById(commodityTypeId));
    }

    /**
     * 新增商品类型
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodityType:add')")
    @Log(title = "新增商品类型", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody CommodityType commodityType) {
        if (!commodityTypeService.checkTypeNameUnique(commodityType)) {
            return error("新增商品类型'" + commodityType.getCommodityTypeName() + "'失败，商品类型已存在");
        }
        commodityType.setCreateBy(getUsername());
        return toAjax(commodityTypeService.insertType(commodityType));
    }

    /**
     * 修改商品类型
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodityType:edit')")
    @Log(title = "修改商品类型", businessType = BusinessType.UPDATE)
    @PutMapping("/edit")
    public AjaxResult edit(@Validated @RequestBody CommodityType type) {
        Long commodityId = type.getCommodityTypeId();
        if (!commodityTypeService.checkTypeNameUnique(type)) {
            return error("修改商品类型'" + type.getCommodityTypeName() + "'失败，商品类型已存在");
        } else if (type.getParentId().equals(commodityId)) {
            return error("修改商品类型'" + type.getCommodityTypeName() + "'失败，上级商品类型不能是自己");
        } else if (StringUtils.equals(UserConstants.DEPT_DISABLE, type.getStatus()) && commodityTypeService.selectNormalChildrenTypeById(commodityId) > 0) {
            return error("该商品类型包含未停用的子商品类型！");
        }
        type.setUpdateBy(getUsername());
        return toAjax(commodityTypeService.updateType(type));
    }

    /**
     * 删除商品类型
     */
    @PreAuthorize("@ss.hasPermi('baseDate:commodityType:remove')")
    @Log(title = "商品类型管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{commodityId}")
    public AjaxResult remove(@PathVariable Long commodityId) {
        if (commodityTypeService.hasChildByCommodityId(commodityId)) {
            return warn("存在下级商品类型,不允许删除");
        }
        return toAjax(commodityTypeService.deleteTypeById(commodityId));
    }
}
