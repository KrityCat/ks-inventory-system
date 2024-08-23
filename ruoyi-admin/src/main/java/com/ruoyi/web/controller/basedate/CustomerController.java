package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.Customer;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 客户资料
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/customer")
public class CustomerController extends BaseController {

    @Autowired
    private CustomerService CtService;

    /**
     * 查询客户接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:list')")
    @GetMapping("/list")
    public TableDataInfo list(Customer bo) {
        startPage();
        List<Customer> list = CtService.CustomerQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询客户详情接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:query')")
    @GetMapping(value = {"/", "/{customerId}"})
    public AjaxResult getInfo(@PathVariable(value = "customerId", required = false) Long customerId) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(customerId)) {
            Customer customer = CtService.selectCustomerById(customerId);
            ajax.put(AjaxResult.DATA_TAG, customer);
        }
        return ajax;
    }

    /**
     * 新增接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:add')")
    @Log(title = "新增客户资料", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody Customer bo) {
        bo.setCreateBy(getUsername());
        return toAjax(CtService.insertCustomer(bo));
    }

    /**
     * 修改接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:update')")
    @Log(title = "修改客户资料", businessType = BusinessType.INSERT)
    @PutMapping("/update")
    public AjaxResult edit(@Validated @RequestBody Customer bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(CtService.updateCustomer(bo));
    }

    /**
     * 删除接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:remove')")
    @Log(title = "删除客户资料", businessType = BusinessType.INSERT)
    @DeleteMapping("/{customerIds}")
    public AjaxResult remove(@PathVariable Long[] customerIds) {
        return toAjax(CtService.deleteCustomerByIds(customerIds));
    }

    /**
     * 模板接口
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Customer> util = new ExcelUtil<Customer>(Customer.class);
        util.importTemplateExcel(response, "客户数据");
    }

    /**
     * 导入接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:import')")
    @Log(title = "导入客户资料", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<Customer> util = new ExcelUtil<Customer>(Customer.class);
        List<Customer> CustomerList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = CtService.importCustomer(CustomerList, updateSupport, operName);
        return success(message);
    }

    /**
     * 导出接口
     */
    @PreAuthorize("@ss.hasPermi('baseDate:customer:export')")
    @Log(title = "导出客户资料", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Customer bo) {
        List<Customer> list = CtService.CustomerQuery(bo);
        ExcelUtil<Customer> util = new ExcelUtil<Customer>(Customer.class);
        util.exportExcel(response, list, "客户数据");
    }
}
