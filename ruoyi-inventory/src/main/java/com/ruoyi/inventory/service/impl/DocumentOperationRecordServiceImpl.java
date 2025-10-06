package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.DocumentOperationRecord;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.inventory.mapper.DocumentOperationRecordMapper;
import com.ruoyi.inventory.service.IDocumentOperationRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 单据操作记录Service业务层处理
 *
 * @author KrityCat
 * @date 2024-11-16
 */
@Service
public class DocumentOperationRecordServiceImpl implements IDocumentOperationRecordService {
    @Autowired
    private DocumentOperationRecordMapper documentOperationRecordMapper;

    /**
     * 查询单据操作记录
     *
     * @param logId 单据操作记录主键
     * @return 单据操作记录
     */
    @Override
    public DocumentOperationRecord selectDocumentOperationRecordByLogId(Long logId) {
        return documentOperationRecordMapper.selectDocumentOperationRecordByLogId(logId);
    }

    /**
     * 查询单据操作记录列表
     *
     * @param documentOperationRecord 单据操作记录
     * @return 单据操作记录
     */
    @Override
    public List<DocumentOperationRecord> selectDocumentOperationRecordList(DocumentOperationRecord documentOperationRecord) {
        return documentOperationRecordMapper.selectDocumentOperationRecordList(documentOperationRecord);
    }

    /**
     * 新增单据操作记录
     *
     * @param documentOperationRecord 单据操作记录
     * @return 结果
     */
    @Override
    public int insertDocumentOperationRecord(DocumentOperationRecord documentOperationRecord) {
        return documentOperationRecordMapper.insertDocumentOperationRecord(documentOperationRecord);
    }

    /**
     * 修改单据操作记录
     *
     * @param documentOperationRecord 单据操作记录
     * @return 结果
     */
    @Override
    public int updateDocumentOperationRecord(DocumentOperationRecord documentOperationRecord) {
        documentOperationRecord.setUpdateTime(DateUtils.getNowDate());
        return documentOperationRecordMapper.updateDocumentOperationRecord(documentOperationRecord);
    }

    /**
     * 批量删除单据操作记录
     *
     * @param logIds 需要删除的单据操作记录主键
     * @return 结果
     */
    @Override
    public int deleteDocumentOperationRecordByLogIds(Long[] logIds) {
        return documentOperationRecordMapper.deleteDocumentOperationRecordByLogIds(logIds);
    }

    /**
     * 删除单据操作记录信息
     *
     * @param logId 单据操作记录主键
     * @return 结果
     */
    @Override
    public int deleteDocumentOperationRecordByLogId(Long logId) {
        return documentOperationRecordMapper.deleteDocumentOperationRecordByLogId(logId);
    }
}
