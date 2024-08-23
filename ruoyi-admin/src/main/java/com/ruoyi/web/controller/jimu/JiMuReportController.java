package com.ruoyi.web.controller.jimu;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.JiMuReport;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.system.service.JiMuReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 在线excel设计器
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/jiMuReport")
public class JiMuReportController extends BaseController {

    @Autowired
    Environment environment;
    @Autowired
    private JiMuReportService JiMuReportService;

    @GetMapping("/index")
    public String index() {
        String hostIp = IpUtils.getHostIp();
        String property = environment.getProperty("ruoyi.reportUrl");
        String format = String.format(property, hostIp);
        return format + "/jmreport/list";
    }

    @GetMapping("/view")
    public String view() {
        String hostIp = IpUtils.getHostIp();
        String property = environment.getProperty("ruoyi.reportUrl");
        String format = String.format(property, hostIp);
        return format + "/jmreport/view";
    }

    /**
     * 查询在线excel设计器接口
     */
//    @PreAuthorize("@ss.hasPermi('baseDate:jiMuReport:list')")
    @GetMapping("/list")
    public TableDataInfo list(JiMuReport bo) {
        startPage();
        List<JiMuReport> list = JiMuReportService.JiMuReportQuery(bo);
        return getDataTable(list);
    }


    /**
     * 查询在线excel设计器详情接口
     */
//    @PreAuthorize("@ss.hasPermi('baseDate:jiMuReport:query')")
    @GetMapping(value = {"/", "/{id}"})
    public AjaxResult getInfo(@PathVariable(value = "id", required = false) String id) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(id)) {
            JiMuReport jiMuReport = JiMuReportService.selectJiMuReportById(id);
            ajax.put(AjaxResult.DATA_TAG, jiMuReport);
        }
        return ajax;
    }


}
