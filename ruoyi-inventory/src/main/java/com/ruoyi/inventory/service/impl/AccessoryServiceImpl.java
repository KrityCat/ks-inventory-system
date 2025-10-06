package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.Accessory;
import com.ruoyi.inventory.mapper.AccessoryMapper;
import com.ruoyi.inventory.service.AccessoryService;
import jakarta.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 配件资料Service业务层处理
 *
 * @author KrityCat
 */
@Service
public class AccessoryServiceImpl implements AccessoryService {

    private static final Logger log = LoggerFactory.getLogger(AccessoryServiceImpl.class);

    @Autowired
    protected Validator validator;

    @Autowired
    private AccessoryMapper accessoryMapper;

    /**
     * 配件资料查询
     */
    @Override
    public List<Accessory> accessoryQuery(Accessory bo) {
        return accessoryMapper.accessoryQuery(bo);
    }

    /**
     * 配件操作查询
     */
    @Override
    public List<Accessory> accessoryOperationRecordQuery(Accessory bo) {
        return accessoryMapper.accessoryOperationRecordQuery(bo);
    }

    /**
     * 通过配件ID查询配件
     */
    @Override
    public Accessory selectAccessoryById(Long accessoryId) {
        return accessoryMapper.selectAccessoryById(accessoryId);
    }


    /**
     * 新增保存配件资料
     *
     * @param bo 配件资料
     * @return 结果
     */
    @Override
    @Transactional
    public int insertAccessory(Accessory bo) {
        return accessoryMapper.insertAccessory(bo);
    }

    /**
     * 新增保存配件操作
     *
     * @param bo 配件资料
     * @return 结果
     */
    @Override
    @Transactional
    public int insertAccessoryRecord(Accessory bo) {
        return accessoryMapper.insertAccessoryRecord(bo);
    }

    /**
     * 修改保存配件资料
     *
     * @param bo 配件资料
     * @return 结果
     */
    @Override
    @Transactional
    public int updateAccessory(Accessory bo) {
        return accessoryMapper.updateAccessory(bo);
    }

    /**
     * 删除配件资料
     *
     * @param accessoryIds 需要删除的配件ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteAccessoryByIds(Long[] accessoryIds) {
        return accessoryMapper.deleteAccessoryByIds(accessoryIds);
    }
}
