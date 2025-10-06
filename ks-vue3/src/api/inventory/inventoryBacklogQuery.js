import request from '@/utils/request'

// 查询库存积压列表
export function selectInventoryBacklogQuery(query) {
  return request({
    url: '/inventory/inventoryBacklogQuery/list',
    method: 'get',
    params: query
  })
}