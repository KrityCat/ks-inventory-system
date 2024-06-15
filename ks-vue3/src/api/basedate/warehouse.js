import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询仓库信息列表
export function listWarehouse(query) {
  return request({
    url: '/baseDate/warehouse/list',
    method: 'get',
    params: query
  })
}

// 查询用户详细
export function getWarehouse(warehouseId) {
  return request({
    url: '/baseDate/warehouse/' + parseStrEmpty(warehouseId),
    method: 'get'
  })
}

// 新增仓库
export function addWarehouse(data) {
  return request({
    url: '/baseDate/warehouse/add',
    method: 'post',
    data: data
  })
}

// 修改仓库
export function updateWarehouse(data) {
  return request({
    url: '/baseDate/warehouse/update',
    method: 'put',
    data: data
  })
}

// 删除仓库
export function delWarehouse(warehouseId) {
  return request({
    url: '/baseDate/warehouse/' + warehouseId,
    method: 'delete'
  })
}


// 仓库状态修改
export function changeWarehouseStatus(WarehouseId, WarehouseValid) {
  const data = {
    WarehouseId,
    WarehouseValid
  }
  return request({
    url: '/baseDate/warehouse/changeStatus',
    method: 'put',
    data: data
  })
}