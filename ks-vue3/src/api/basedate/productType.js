import request from '@/utils/request'

// 查询部门列表
export function listProductType(query) {
  return request({
    url: '/baseDate/productType/list',
    method: 'get',
    params: query
  })
}

// 查询货品类型列表（排除节点）
export function listProductTypeExcludeChild(productId) {
  return request({
    url: '/baseDate/productType/list/exclude/' + productId,
    method: 'get'
  })
}

// 查询货品类型详细
export function getProductType(productTypeId) {
  return request({
    url: '/baseDate/productType/' + productTypeId,
    method: 'get'
  })
}

// 新增货品类型
export function addProductType(data) {
  return request({
    url: '/baseDate/productType/add',
    method: 'post',
    data: data
  })
}

// 修改货品类型
export function updateProductType(data) {
  return request({
    url: '/baseDate/productType/edit',
    method: 'put',
    data: data
  })
}

// 删除货品类型
export function delProductType(productId) {
  return request({
    url: '/baseDate/productType/' + productId,
    method: 'delete'
  })
}