import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售订单详情
export function getSalesOrder(systematicOrderForm) {
  return request({
    url: '/sales/salesOrderProcessing/' + parseStrEmpty(systematicOrderForm),
    method: 'get'
  })
}

// 保存销售订单
export function saveSalesOrder(data) {
  return request({
    url: '/sales/salesOrderProcessing/save',
    method: 'post',
    data: data
  })
}

// 删除销售订单
export function delSalesOrder(data) {
  return request({
    url: '/sales/salesOrderProcessing/delete',
    method: 'post',
    data: data
  })
}