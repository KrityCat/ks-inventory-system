import request from '@/utils/request'


// 销售金额与毛利润查询
export function salesAmountQuery(query) {
  return request({
    url: '/index/salesAmountQuery',
    method: 'get',
    params: query
  })
}

// 待审核单据查询
export function salesNotTakeEffectQuery(query) {
  return request({
    url: '/index/salesNotTakeEffectQuery',
    method: 'get',
    params: query
  })
}

// 查询货品库存积压告警列表
export function listOverstockProduct(query) {
  return request({
    url: '/index/overstockList',
    method: 'get',
    params: query
  })
}

// 查询货品库存不足告警列表
export function listDangerProduct(query) {
  return request({
    url: '/index/dangerList',
    method: 'get',
    params: query
  })
}

// 积压3个月未出预警列表
export function listThreeOverstock(query) {
  return request({
    url: '/index/threeOverstockList',
    method: 'get',
    params: query
  })
}

// 积压6个月未出预警列表
export function listSixOverstock(query) {
  return request({
    url: '/index/sixOverstockList',
    method: 'get',
    params: query
  })
}

// 积压12个月未出预警列表
export function listTwelveOverstock(query) {
  return request({
    url: '/index/twelveOverstockList',
    method: 'get',
    params: query
  })
}

