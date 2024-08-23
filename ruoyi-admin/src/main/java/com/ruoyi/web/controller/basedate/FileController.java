package com.ruoyi.web.controller.basedate;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.File;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.MimeTypeUtils;
import com.ruoyi.system.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 文件共享
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/baseDate/fileSharing")
public class FileController extends BaseController {

    @Autowired
    private FileService fileService;

    /**
     * 文件查询
     */
    @PreAuthorize("@ss.hasPermi('baseDate:fileSharing:list')")
    @GetMapping("/list")
    public TableDataInfo list(File bo) {
        startPage();
        List<File> list = fileService.fileQuery(bo);
        return getDataTable(list);
    }

    /**
     * 文件详情查询
     */
    @PreAuthorize("@ss.hasPermi('baseDate:fileSharing:query')")
    @GetMapping(value = {"/", "/{fileId}"})
    public AjaxResult getInfo(@PathVariable(value = "fileId", required = false) Long fileId) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(fileId)) {
            File file = fileService.selectFileById(fileId);
            ajax.put(AjaxResult.DATA_TAG, file);
        }
        return ajax;
    }

    /**
     * 文件上传
     */
    @PreAuthorize("@ss.hasPermi('baseDate:fileSharing:upload')")
    @PostMapping("/upload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file) throws Exception {
        if (!file.isEmpty()) {
            // 获取文件原始名
            String originalFilename = file.getOriginalFilename();
            String fileUrl = FileUploadUtils.upload(RuoYiConfig.getAvatarPath(), file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);
            if (fileService.upload(originalFilename, fileUrl)) {
                AjaxResult ajax = AjaxResult.success();
                ajax.put("fileUrl", fileUrl);
                return ajax;
            }
        }
        return error("上传文件异常，请联系管理员");
    }

    /**
     * 文件新增
     */
    @PreAuthorize("@ss.hasPermi('baseDate:fileSharing:update')")
    @Log(title = "新增打印文件", businessType = BusinessType.INSERT)
    @PutMapping("/add")
    public AjaxResult add(@Validated @RequestBody File bo) {
        bo.setCreateBy(getUsername());
        return toAjax(fileService.addFileName(bo));
    }

    /**
     * 文件修改
     */
    @PreAuthorize("@ss.hasPermi('baseDate:fileSharing:update')")
    @Log(title = "修改打印文件", businessType = BusinessType.INSERT)
    @PutMapping("/update")
    public AjaxResult edit(@Validated @RequestBody File bo) {
        bo.setUpdateBy(getUsername());
        return toAjax(fileService.updateFileName(bo));
    }

    /**
     * 文件删除
     */
    @PreAuthorize("@ss.hasPermi('baseDate:fileSharing:remove')")
    @Log(title = "删除打印文件", businessType = BusinessType.INSERT)
    @DeleteMapping("/{fileId}")
    public AjaxResult remove(@PathVariable Long[] fileId) {
        return toAjax(fileService.deleteFileByIds(fileId));
    }

}
