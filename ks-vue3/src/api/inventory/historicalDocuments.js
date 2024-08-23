import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询库存头单列表
export function headReceiptQuery(query) {
  return request({
    url: '/inventory/historicalDocuments/head',
    method: 'get',
    params: query
  })
}

// 查询库存明细列表
export function detailReceiptQuery(query) {
  return request({
    url: '/inventory/historicalDocuments/detail',
    method: 'get',
    params: query
  })
}

// 查询库存头单详情
export function getHeadReceipt(SystematicReceipt) {
  return request({
    url: '/inventory/historicalDocuments/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

/**   删除库存单据    */
export function delInventoryReceipt(data) {
  return request({
    url: '/inventory/historicalDocuments/delete',
    method: 'post',
    data: data
  })
}