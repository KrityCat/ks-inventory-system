package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.Warehouse;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.system.mapper.WarehouseMapper;
import com.ruoyi.system.service.WarehouseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.util.List;

/**
 * 仓库 业务层处理
 *
 * @author KrityCat
 */
@Service
public class WarehouseServiceImpl implements WarehouseService {

    private static final Logger log = LoggerFactory.getLogger(WarehouseServiceImpl.class);
    @Autowired
    protected Validator validator;
    @Autowired
    private WarehouseMapper WhMapper;

    /**
     * @return
     */
    @Override
    public List<Warehouse> WarehouseQuery(Warehouse bo) {
        return WhMapper.WarehouseQuery(bo);
    }

    /**
     * 通过仓库ID查询仓库
     *
     * @param warehouseId 仓库ID
     * @return 仓库对象信息
     */
    @Override
    public Warehouse selectWarehouseById(Long warehouseId) {
        return WhMapper.selectWarehouseById(warehouseId);
    }

    /**
     * 新增保存仓库信息
     *
     * @param bo 用户信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertWarehouse(Warehouse bo) {
        return WhMapper.insertWarehouse(bo);
    }

    /**
     * 修改保存仓库信息
     *
     * @param bo 用户信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateWarehouse(Warehouse bo) {
        return WhMapper.updateWarehouse(bo);
    }

    /**
     * 删除仓库信息
     *
     * @param warehouseIds 需要删除的仓库ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteWarehouseByIds(Long[] warehouseIds) {
        return WhMapper.deleteWarehouseByIds(warehouseIds);
    }

    /**
     * 导入仓库数据
     *
     * @param warehousesList  仓库数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    @Override
    public String importWarehouse(List<Warehouse> warehousesList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(warehousesList) || warehousesList.isEmpty()) {
            throw new ServiceException("导入仓库数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Warehouse bo : warehousesList) {
            try {
                // 验证是否存在这个仓库
                Warehouse w = WhMapper.selectWarehouseByWarehouseName(bo.getWarehouseName());
                if (StringUtils.isBlank(bo.getWarehouseName()) || StringUtils.isBlank(bo.getWarehouseDirector()) || StringUtils.isBlank(bo.getWarehouseTelephone())) {
                    failureNum++;
                    throw new ServiceException("仓库名称、负责人与联系电话不能为空！");
                } else if (StringUtils.isNull(w)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setWarehouseName(bo.getWarehouseName());
                    bo.setCreateBy(operName);
                    WhMapper.insertWarehouse(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、仓库 " + bo.getWarehouseName() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setWarehouseId(w.getWarehouseId());
                    bo.setUpdateBy(operName);
                    WhMapper.updateWarehouse(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、仓库 " + bo.getWarehouseName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、仓库 " + bo.getWarehouseName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、仓库 " + bo.getWarehouseName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }
}
