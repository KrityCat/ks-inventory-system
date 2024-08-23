import request from '@/utils/request'

// 查询库存货品列表
export function selectInventoryItemInquiry(query) {
  return request({
    url: '/inventory/inventoryItemInquiry/list',
    method: 'get',
    params: query
  })
}