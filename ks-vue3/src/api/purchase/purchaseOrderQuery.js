import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询采购订单头单列表
export function purchaseOrderHeadQuery(query) {
  return request({
    url: '/purchase/purchaseOrderQuery/headQuery',
    method: 'get',
    params: query
  })
}

// 查询采购订单明细列表
export function detailQuery(query) {
  return request({
    url: '/purchase/purchaseOrderQuery/detailQuery',
    method: 'get',
    params: query
  })
}

// 查询采购订单详情
export function getPurchaseOrder(systematicOrderForm) {
  return request({
    url: '/purchase/purchaseOrderQuery/' + parseStrEmpty(systematicOrderForm),
    method: 'get'
  })
}

// 删除采购订单
export function delPurchaseOrder(data) {
  return request({
    url: '/purchase/purchaseOrderQuery/delete',
    method: 'post',
    data: data
  })
}