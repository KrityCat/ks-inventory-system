import request from '@/utils/request'
import {parseStrEmpty} from "@/utils/ruoyi";

// 查询配件列表
export function listAccessory(query) {
    return request({
        url: '/inventory/accessory/list',
        method: 'get',
        params: query
    })
}

// 查询配件操作列表
export function listRecord(query) {
    return request({
        url: '/inventory/accessory/recordList',
        method: 'get',
        params: query
    })
}

// 查询配件详细
export function getAccessory(accessoryId) {
    return request({
        url: '/inventory/accessory/' + parseStrEmpty(accessoryId),
        method: 'get'
    })
}

// 新增配件
export function addAccessory(data) {
    return request({
        url: '/inventory/accessory/add',
        method: 'post',
        data: data
    })
}

// 新增配件
export function addAccessoryRecord(data) {
    return request({
        url: '/inventory/accessory/addRecord',
        method: 'post',
        data: data
    })
}

// 修改配件
export function updateAccessory(data) {
    return request({
        url: '/inventory/accessory/update',
        method: 'put',
        data: data
    })
}

// 删除配件
export function delAccessory(accessoryId) {
    return request({
        url: '/inventory/accessory/' + accessoryId,
        method: 'delete'
    })
}
