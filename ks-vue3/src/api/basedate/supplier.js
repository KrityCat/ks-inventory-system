import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询供应商信息列表
export function listSupplier(query) {
  return request({
    url: '/baseDate/supplier/list',
    method: 'get',
    params: query
  })
}

// 查询供应商详细
export function getSupplier(supplierId) {
  return request({
    url: '/baseDate/supplier/' + parseStrEmpty(supplierId),
    method: 'get'
  })
}

// 新增供应商
export function addSupplier(data) {
  return request({
    url: '/baseDate/supplier/add',
    method: 'post',
    data: data
  })
}

// 修改供应商
export function updateSupplier(data) {
  return request({
    url: '/baseDate/supplier/update',
    method: 'put',
    data: data
  })
}

// 删除供应商
export function delSupplier(supplierId) {
  return request({
    url: '/baseDate/supplier/' + supplierId,
    method: 'delete'
  })
}
