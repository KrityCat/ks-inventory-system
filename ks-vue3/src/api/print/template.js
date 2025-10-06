import request from '@/utils/request'

// 查询打印模板列表
export function listTemplate(query) {
    return request({
        url: '/print/template/list',
        method: 'get',
        params: query
    })
}

// 查询打印模板详细
export function getTemplate(templateId) {
    return request({
        url: '/print/template/' + templateId,
        method: 'get'
    })
}

// 根据 Key 查询打印模板详细
export function getTemplateByKey(templateKey) {
    return request({
        url: '/print/template/key/' + templateKey,
        method: 'get'
    })
}

// 新增打印模板
export function addTemplate(data) {
    return request({
        url: '/print/template',
        method: 'post',
        data: data
    })
}

// 修改打印模板
export function updateTemplate(data) {
    return request({
        url: '/print/template/update',
        method: 'put',
        data: data
    })
}

// 删除打印模板
export function delTemplate(templateIds) {
    return request({
        url: '/print/template/' + templateIds,
        method: 'delete'
    })
}