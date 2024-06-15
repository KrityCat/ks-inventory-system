import request from '@/utils/request'

// 查询商品类型列表
export function listCommodityType(query) {
  return request({
    url: '/baseDate/commodityType/list',
    method: 'get',
    params: query
  })
}

// 查询商品类型列表（排除节点）
export function listCommodityTypeExcludeChild(commodityId) {
  return request({
    url: '/baseDate/commodityType/list/exclude/' + commodityId,
    method: 'get'
  })
}

// 查询商品类型详细
export function getCommodityType(commodityTypeId) {
  return request({
    url: '/baseDate/commodityType/' + commodityTypeId,
    method: 'get'
  })
}

// 新增商品类型
export function addCommodityType(data) {
  return request({
    url: '/baseDate/commodityType',
    method: 'post',
    data: data
  })
}

// 修改商品类型
export function updateCommodityType(data) {
  return request({
    url: '/baseDate/commodityType',
    method: 'put',
    data: data
  })
}

// 删除商品类型
export function delCommodityType(commodityTypeId) {
  return request({
    url: '/baseDate/commodityType/' + commodityTypeId,
    method: 'delete'
  })
}
