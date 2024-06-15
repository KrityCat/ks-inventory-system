import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售头单详情
export function getSalesOrder(systematicReceipt) {
  return request({
    url: '/system/sales/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 保存销售退库单据
export function saveSalesReceipt(data) {
  return request({
    url: '/system/sales/saveSalesRetreat',
    method: 'post',
    data: data
  })
}
