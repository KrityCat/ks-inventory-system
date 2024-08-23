import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询售后头单列表
export function headQuery(query) {
  return request({
    url: '/afterSales/afterSalesQuery/headQuery',
    method: 'get',
    params: query
  })
}

// 查询售后明细列表
export function detailQuery(query) {
  return request({
    url: '/afterSales/afterSalesQuery/detailQuery',
    method: 'get',
    params: query
  })
}

// 查询售后单据详情
export function getAfterSales(systematicReceipt) {
  return request({
    url: '/afterSales/afterSalesQuery/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 删除售后单据
export function delAfterSales(data) {
  return request({
    url: '/afterSales/afterSalesQuery/delete',
    method: 'post',
    data: data
  })
}