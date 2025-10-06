import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询库存头单列表
export function headQuery(query) {
  return request({
    url: '/inventory/inventoryReceiptQuery/headQuery',
    method: 'get',
    params: query
  })
}

// 查询库存明细列表
export function detailQuery(query) {
  return request({
    url: '/inventory/inventoryReceiptQuery/detailQuery',
    method: 'get',
    params: query
  })
}

// 查询库存单据详情
export function getReceipt(SystematicReceipt) {
  return request({
    url: '/inventory/inventoryReceiptQuery/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

/**   删除库存单据    */
export function delReceipt(data) {
  return request({
    url: '/inventory/inventoryReceiptQuery/delete',
    method: 'post',
    data: data
  })
}