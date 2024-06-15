import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售头单列表
export function listSalesOrder(query) {
  return request({
    url: '/system/sales/SalesHeadQuery',
    method: 'get',
    params: query
  })
}

// 查询销售明细列表
export function listSalesDetailOrder(query) {
  return request({
    url: '/system/sales/SalesDetailQuery',
    method: 'get',
    params: query
  })
}

// 查询销售头单详情
export function getSalesOrder(systematicReceipt) {
  return request({
    url: '/system/sales/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 删除销售单据
export function delSalesReceipt(data) {
  return request({
    url: '/system/sales/delete',
    method: 'post',
    data: data
  })
}