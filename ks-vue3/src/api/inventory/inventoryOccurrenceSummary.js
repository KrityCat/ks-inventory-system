import request from '@/utils/request'

/** 货品发生汇总查询 */
export function inventorySummaryQuery(query) {
  return request({
    url: '/inventory/inventoryOccurrenceSummary/list',
    method: 'get',
    params: query
  })
}