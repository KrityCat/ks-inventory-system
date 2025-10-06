package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.DocumentOperationRecord;

import java.util.List;

/**
 * 单据操作记录Mapper接口
 *
 * @author KrityCat
 * @date 2024-11-16
 */
public interface DocumentOperationRecordMapper {
    /**
     * 查询单据操作记录
     *
     * @param logId 单据操作记录主键
     * @return 单据操作记录
     */
    DocumentOperationRecord selectDocumentOperationRecordByLogId(Long logId);

    /**
     * 查询单据操作记录列表
     *
     * @param documentOperationRecord 单据操作记录
     * @return 单据操作记录集合
     */
    List<DocumentOperationRecord> selectDocumentOperationRecordList(DocumentOperationRecord documentOperationRecord);

    /**
     * 新增单据操作记录
     *
     * @param documentOperationRecord 单据操作记录
     * @return 结果
     */
    int insertDocumentOperationRecord(DocumentOperationRecord documentOperationRecord);

    /**
     * 修改单据操作记录
     *
     * @param documentOperationRecord 单据操作记录
     * @return 结果
     */
    int updateDocumentOperationRecord(DocumentOperationRecord documentOperationRecord);

    /**
     * 删除单据操作记录
     *
     * @param logId 单据操作记录主键
     * @return 结果
     */
    int deleteDocumentOperationRecordByLogId(Long logId);

    /**
     * 批量删除单据操作记录
     *
     * @param logIds 需要删除的数据主键集合
     * @return 结果
     */
    int deleteDocumentOperationRecordByLogIds(Long[] logIds);
}
