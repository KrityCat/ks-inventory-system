import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询客户信息列表
export function listCustomer(query) {
  return request({
    url: '/baseDate/customer/list',
    method: 'get',
    params: query
  })
}

// 查询客户详细
export function getCustomer(customerId) {
  return request({
    url: '/baseDate/customer/' + parseStrEmpty(customerId),
    method: 'get'
  })
}

// 新增客户
export function addCustomer(data) {
  return request({
    url: '/baseDate/customer/add',
    method: 'post',
    data: data
  })
}

// 修改客户
export function updateCustomer(data) {
  return request({
    url: '/baseDate/customer/update',
    method: 'put',
    data: data
  })
}

// 删除客户
export function delCustomer(customerId) {
  return request({
    url: '/baseDate/customer/' + customerId,
    method: 'delete'
  })
}
