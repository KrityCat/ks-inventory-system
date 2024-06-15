import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询库存头单列表
export function headReceiptQuery(query) {
  return request({
    url: '/system/inventory/headReceiptQuery',
    method: 'get',
    params: query
  })
}

// 查询库存明细列表
export function detailReceiptQuery(query) {
  return request({
    url: '/system/inventory/detailReceiptQuery',
    method: 'get',
    params: query
  })
}

// 查询库存头单详情
export function getHeadReceipt(SystematicReceipt) {
  return request({
    url: '/system/inventory/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

/**   删除库存单据    */
export function delInventoryReceipt(data) {
  return request({
    url: '/system/inventory/delete',
    method: 'post',
    data: data
  })
}