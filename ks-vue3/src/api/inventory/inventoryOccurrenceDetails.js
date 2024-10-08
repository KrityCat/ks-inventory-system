import request from '@/utils/request'

/** 货品发生明细查询 */
export function occurrenceDetailsQuery(query) {
  return request({
    url: '/inventory/inventoryOccurrenceDetails/list',
    method: 'get',
    params: query
  })
}