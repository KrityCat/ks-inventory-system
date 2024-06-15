import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售头单详情
export function getSalesOrder(systematicReceipt) {
  return request({
    url: '/system/sales/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 保存销售出库单据
export function saveSalesOutbound(data) {
  return request({
    url: '/system/sales/saveSalesOutbound',
    method: 'post',
    data: data
  })
}
