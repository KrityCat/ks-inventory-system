import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售头单列表
export function headQuery(query) {
  return request({
    url: '/sales/salesReceiptQuery/headQuery',
    method: 'get',
    params: query
  })
}

// 查询销售明细列表
export function detailQuery(query) {
  return request({
    url: '/sales/salesReceiptQuery/detailQuery',
    method: 'get',
    params: query
  })
}

// 查询销售头单详情
export function getSalesReceipt(systematicReceipt) {
  return request({
    url: '/sales/salesReceiptQuery/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 删除销售单据
export function delSalesReceipt(data) {
  return request({
    url: '/sales/salesReceiptQuery/delete',
    method: 'post',
    data: data
  })
}