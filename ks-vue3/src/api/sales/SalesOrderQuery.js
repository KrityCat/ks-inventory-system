import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售订单头单列表
export function headQuery(query) {
  return request({
    url: '/sales/salesOrderQuery/headQuery',
    method: 'get',
    params: query
  })
}

// 查询销售订单明细列表
export function detailQuery(query) {
  return request({
    url: '/sales/salesOrderQuery/detailQuery',
    method: 'get',
    params: query
  })
}

// 查询销售订单详情
export function getSalesOrder(systematicOrderForm) {
  return request({
    url: '/sales/salesOrderQuery/' + parseStrEmpty(systematicOrderForm),
    method: 'get'
  })
}

// 删除销售订单
export function delSalesOrder(data) {
  return request({
    url: '/sales/salesOrderQuery/delete',
    method: 'post',
    data: data
  })
}