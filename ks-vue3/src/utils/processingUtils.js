/** 单据制作公共方法 */
import RMBConverter from "@/utils/RMBConverter";
import {
    customerList,
    getReceipt,
    inventoryList,
    lockList,
    selectInventoryQtyQuery,
    supplierList,
    warehouseList,
} from "@/api/common/CommonReceipt";

const data = reactive({
    productBatch: {
        productId: null,
        receiptStatus: null,
    }
})

const {
    productBatch,
} = toRefs(data);


/** 新增制作 */
export async function addProcessingBatch(router, proxy, processPath) {
    // 添加基础错误处理
    try {
        // 使用路由名称替代路径
        await router.push({name: processPath});

        // 延迟确保页面加载完成
        setTimeout(() => {
            proxy.$tab?.refreshPage?.();
            proxy.$modal.msgSuccess("新增成功");
        }, 100); // 根据页面加载速度调整延时

    } catch (error) {
        console.log(error);
        proxy.$modal.msgError("新增失败，请重试");
    }
}

/** 删除订单 */
export async function deleteReceiptBatch(router, proxy, form, getOrder, delOrder, processPath) {
    try {
        const {systematicReceipt} = form.value;
        const receiptNo = systematicReceipt;

        // 前置校验
        if (!receiptNo) {
            return proxy.$modal.msgWarning('请选择要删除的单据');
        }

        // 获取单据详情
        const orderRes = await getOrder(receiptNo);
        if (!orderRes.data) {
            return proxy.$modal.msgError('单据信息获取失败');
        }

        // 确认弹窗
        const confirm = await proxy.$modal.confirm(
            `确认删除系统编号为【${receiptNo}】的单据？`
        );
        if (!confirm) return;

        // 执行删除
        await delOrder(orderRes.data);
        proxy.$modal.msgSuccess(`已删除系统编号为【${receiptNo}】的单据`);

        // 路由跳转与刷新
        await router.push({name: processPath});
        setTimeout(() => {
            proxy.$tab?.refreshPage?.();
        }, 100);

    } catch (error) {
        console.log(error);
        proxy.$modal.msgError(`已取消删除`);
    }
}


/** 当前日期显示 */
export function getNowTime() {
    const now = new Date();
    return now.toLocaleDateString('en-CA');
}

/** 批量获取产品锁定量 */
async function batchFetchLockQtys(productIds, retrievalIds) {
    if (!productIds || productIds.length === 0) return {};
    if (!retrievalIds) return {};

    try {
        // 遍历每个产品ID，逐个查询锁定量
        const results = await Promise.all(
            productIds.map(async (id) => {
                try {
                    // **关键改动：调用原列表接口，但传递单个 productId **
                    const response = await lockList({
                        productId: id,
                        retrievalId: retrievalIds
                    });

                    // **处理响应格式：假设返回的 rows 是包含单个对象的数组**
                    const product = response.rows[0];
                    const lockQty = product ? Number(product.lockQty) || 0 : 0;
                    return {id, lockQty};
                } catch (error) {
                    console.error(`获取产品 ${id} 锁定量失败:`, error);
                    return {id, lockQty: 0};
                }
            })
        );

        // 转换为 { 产品ID: 锁定量 } 格式
        return results.reduce((acc, {id, lockQty}) => {
            acc[id] = lockQty;
            return acc;
        }, {});
    } catch (error) {
        console.error('批量获取锁定量过程中发生错误:', error);
        return false;
    }
}

/** 异步提交校验 */
export async function SubmitVerification(proxy, form) {
    const {systematicReceipt, receiptType, receiptStatus, warehousingIds, retrievalIds, details} = form.value;

    const productIds = details.map(d => d.productId);

    // const response = await getReceipt(systematicReceipt).catch(() => ({ data: null }));

    // const safeData = response.data || {};

    // const receiptDetailsMap = new Map(
    //     (Array.isArray(safeData.details) ? safeData.details : [])
    //         .map(d => [
    //           d.productId || '未知ID',
    //           Number(d.planQuantity) || 0
    //         ])
    // );

    const lockQtyMap = [3, 6].includes(receiptType)
        ? await batchFetchLockQtys(productIds, retrievalIds).catch(() => ({}))
        : {};

    // 3. 处理数据并合并实时锁定量
    const processedDetails = details.map(item => ({
        ...item,
        productId: item.productId,
        productCode: item.productCode,
        planQuantity: Number(item.planQuantity) || 0,
        // originalPlanQuantity: Number(receiptDetailsMap.get(item.productId)) || 0,
        inventoryQty: Number(item.inventoryQty) || 0,
        assembleLockQty: Number(item.assembleLockQty) || 0,
        lockQty: lockQtyMap[item.productId] || 0
    }));

    // 4. 构建校验规则
    const validationRules = [
        {
            check: () => [7].includes(receiptType) && String(retrievalIds) === String(warehousingIds),
            message: "调入和调出仓库不能一样"
        },
        {check: () => !processedDetails.length, message: "货品明细不能为空"},
        {
            check: () => processedDetails.some(d => !d.productCode),
            message: "货品编号必须选择"
        },
        {
            check: () => {
                const productIds = processedDetails.map(d => d.productId);
                return new Set(productIds).size !== productIds.length;
            },
            message: () => {
                const seenIds = new Map();
                processedDetails.forEach(d => {
                    seenIds.set(d.productId, (seenIds.get(d.productId) || 0) + 1);
                });
                const invalidCodes = [];
                seenIds.forEach((count, productId) => {
                    if (count > 1) {
                        const firstMatch = processedDetails.find(d => d.productId === productId);
                        invalidCodes.push(firstMatch.productCode);
                    }
                });
                return `货品编号：${invalidCodes.join(', ')}，不能存在重复`;
            }
        },
        {
            check: () => [3, 6].includes(receiptType) && processedDetails.some(d => d.lockedGoods == null),
            message: () => {
                const invalidItems = processedDetails.filter(d => d.lockedGoods == null);
                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，锁单货品未选择`;
            }
        },
        {
            check: () => processedDetails.some(d => d.planQuantity === 0),
            message: () => {
                const invalidItems = processedDetails.filter(d => d.planQuantity === 0);
                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量必须大于0`;
            }
        },
        {
            check: () => processedDetails.some(d => d.univalence <= 0),
            message: () => {
                const invalidItems = processedDetails.filter(d => d.univalence <= 0);
                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，单价必须大于0`;
            }
        },
        {
            check: () => receiptStatus === 1 && [2, 3, 6, 7, 9].includes(receiptType) && processedDetails.some(d =>
                d.planQuantity > d.inventoryQty
            ),
            message: () => {
                const invalidItems = processedDetails.filter(d =>
                    d.planQuantity > d.inventoryQty
                );
                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能大于库存数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && [2, 3, 6, 7, 9].includes(receiptType) && processedDetails.some(d =>
                d.planQuantity > (d.inventoryQty - d.lockQty)
            ),
            message: () => {
                const invalidItems = processedDetails.filter(d =>
                    d.planQuantity > (d.inventoryQty - d.lockQty)
                );
                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能超过非单据锁单数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && [8].includes(receiptType) && processedDetails.some(d =>
                d.planQuantity < 0 && Math.abs(d.planQuantity) > d.inventoryQty
            ),
            message: () => {
                const invalidItems = processedDetails.filter(d =>
                    d.planQuantity < 0 && Math.abs(d.planQuantity) > d.inventoryQty
                );
                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能大于库存数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && [8].includes(receiptType) && processedDetails.some(d =>
                d.planQuantity < 0 && Math.abs(d.planQuantity) > (d.inventoryQty - d.lockQty)
            ),
            message: () => {
                const invalidItems = processedDetails.filter(d =>
                    d.planQuantity < 0 && Math.abs(d.planQuantity) > (d.inventoryQty - d.lockQty)
                );

                return `货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能超过非单据锁单数量`;
            }
        },
    ];

    for (const rule of validationRules) {
        // 支持动态生成错误信息
        const errorMessage = typeof rule.message === 'function'
            ? rule.message()
            : rule.message;

        if (rule.check()) {
            proxy.$modal.msgError(errorMessage);
            return false;
        }
    }
    return true;
}

/** 拆装异步提交校验 */
export async function AssemblyVerification(proxy, form) {
    const {
        systematicReceipt,
        receiptStatus,
        warehousingIds,
        retrievalIds,
        retrievalDetails,
        warehousingDetails
    } = form.value;

    const productIds = retrievalDetails.map(d => d.productId);

    const response = await getReceipt(systematicReceipt).catch(() => ({data: null}));

    const safeData = response.data || {};

    const receiptDetailsMap = new Map(
        (Array.isArray(safeData.details) ? safeData.details : [])
            .map(d => [
                d.productId || '未知ID',
                Number(d.planQuantity) || 0
            ])
    );

    const lockQtyMap = await batchFetchLockQtys(productIds, retrievalIds).catch(() => ({}));

    // 3. 处理数据并合并实时锁定量
    const processedDetails = retrievalDetails.map(item => ({
        ...item,
        productId: item.productId,
        productCode: item.productCode,
        planQuantity: Number(item.planQuantity) || 0,
        originalPlanQuantity: Number(receiptDetailsMap.get(item.productId)) || 0,
        inventoryQty: Number(item.inventoryQty) || 0,
        assembleLockQty: Number(item.assembleLockQty) || 0,
        lockQty: lockQtyMap[item.productId] || 0
    }));

    // 4. 构建校验规则
    const validationRules = [
        {check: () => String(retrievalIds) === String(warehousingIds), message: "调入和调出仓库不能一样"},
        {condition: retrievalDetails.length === 0, message: "出库货品明细不能为空"},
        {condition: warehousingDetails.length === 0, message: "入库货品明细不能为空"},
        {
            condition: retrievalDetails.some(it => !it.productCode),
            message: "出库货品编号必须选择"
        },
        {
            condition: warehousingDetails.some(it => !it.productCode),
            message: "入库货品编号必须选择"
        },
        {
            check: () => {
                const productIds = retrievalDetails.map(d => d.productId);
                return new Set(productIds).size !== productIds.length;
            },
            message: () => {
                const seenIds = new Map();
                retrievalDetails.forEach(d => {
                    seenIds.set(d.productId, (seenIds.get(d.productId) || 0) + 1);
                });
                const invalidCodes = [];
                seenIds.forEach((count, productId) => {
                    if (count > 1) {
                        const firstMatch = retrievalDetails.find(d => d.productId === productId);
                        invalidCodes.push(firstMatch.productCode);
                    }
                });
                return `出库货品编号：${invalidCodes.join(', ')}，不能存在重复`;
            }
        },
        {
            check: () => {
                const productIds = warehousingDetails.map(d => d.productId);
                return new Set(productIds).size !== productIds.length;
            },
            message: () => {
                const seenIds = new Map();
                warehousingDetails.forEach(d => {
                    seenIds.set(d.productId, (seenIds.get(d.productId) || 0) + 1);
                });
                const invalidCodes = [];
                seenIds.forEach((count, productId) => {
                    if (count > 1) {
                        const firstMatch = warehousingDetails.find(d => d.productId === productId);
                        invalidCodes.push(firstMatch.productCode);
                    }
                });
                return `入库货品编号：${invalidCodes.join(', ')}，不能存在重复`;
            }
        },
        {
            check: () => retrievalDetails.some(d => d.planQuantity <= 0),
            message: () => {
                const invalidItems = retrievalDetails.filter(d => d.planQuantity <= 0);
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量必须大于0`;
            }
        },
        {
            check: () => warehousingDetails.some(d => d.planQuantity <= 0),
            message: () => {
                const invalidItems = warehousingDetails.filter(d => d.planQuantity <= 0);
                return `入库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量必须大于0`;
            }
        },
        {
            check: () => retrievalDetails.some(d => d.univalence <= 0),
            message: () => {
                const invalidItems = retrievalDetails.filter(d => d.univalence <= 0);
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，单价必须大于0`;
            }
        },
        {
            check: () => warehousingDetails.some(d => d.univalence <= 0),
            message: () => {
                const invalidItems = warehousingDetails.filter(d => d.univalence <= 0);
                return `入库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，单价必须大于0`;
            }
        },
        {
            check: () => processedDetails.some(d => d.lockInventoryQty > d.planQuantity),
            message: () => {
                const invalidItems = retrievalDetails.filter(d => d.lockInventoryQty > d.planQuantity);
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，锁单数量不能大于数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && processedDetails.some(d => {
                const available = d.inventoryQty - d.assembleLockQty;
                return d.lockedGoods === 0 && d.planQuantity > available;
            }),
            message: () => {
                const invalidItems = processedDetails.filter(d => {
                    const available = d.inventoryQty - d.assembleLockQty;
                    return d.lockedGoods === 0 && d.planQuantity > available;
                });
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能大于库存非锁单数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && processedDetails.some(d => {
                return d.planQuantity > d.inventoryQty
            }),
            message: () => {
                const invalidItems = processedDetails.filter(d => {
                    return d.planQuantity > d.inventoryQty
                });
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能大于库存数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && processedDetails.some(d => {
                const available = d.inventoryQty - d.lockQty;
                return d.planQuantity > available;
            }),
            message: () => {
                const invalidItems = processedDetails.filter(d => {
                    const available = d.inventoryQty - d.lockQty;
                    return d.planQuantity > available;
                });
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量不能超过非单据锁单数量`;
            }
        },
        {
            check: () => receiptStatus === 1 && processedDetails.some(d => {
                const available = d.inventoryQty - d.lockQty;
                return d.planQuantity > available;
            }),
            message: () => {
                const invalidItems = processedDetails.filter(d => {
                    const available = d.inventoryQty - d.lockQty;
                    return d.planQuantity > available;
                });
                return `出库货品编号：${invalidItems.map(d => d.productCode).join(', ')}，数量超过已锁单草稿数量，请协商处理！`;
            }
        },
    ];

    for (const rule of validationRules) {
        // 支持动态生成错误信息
        const errorMessage = typeof rule.message === 'function'
            ? rule.message()
            : rule.message;

        if (rule.check()) {
            proxy.$modal.msgError(errorMessage);
            return false;
        }
    }
    return true;
}

/**
 * 通用表格合计行计算方法
 * @param columns
 * @param data
 * @param {Object} [form] - 表单对象
 * @param {Object} [sums] - 汇总对象
 * @param {number[]} skipColumns - 需要清空的列索引数组
 * @param {number[]} decimalColumns - 需要格式化的列索引数组
 * @returns {Array} 合计行数据
 */
export function getColumns(columns, data, form, sums, skipColumns, decimalColumns) {
    columns.forEach((column, index) => {
        if (index === 0) {
            sums[index] = "合计";
            return;
        }

        // 处理需要清空的列
        if (skipColumns.includes(index)) {
            sums[index] = "";
            return;
        }

        if (column.property !== undefined) {
            const values = data.map((item) => Number(item[column.property]));
            if (!values.every((value) => isNaN(value))) {
                sums[index] = values.reduce((prev, curr) => {
                    const value = Number(curr);
                    if (!isNaN(value)) {
                        return prev + curr;
                    } else {
                        return prev;
                    }
                }, 0);
                if (decimalColumns.includes(index)) {
                    sums[index] = Number(sums[index]).toFixed(2);
                    form.value.orderFormAmount = sums[index];
                    form.value.orderCapitalizeAmount = RMBConverter.numberToChinese(
                        sums[index]
                    );
                    form.value.totalAmount = sums[index];
                    form.value.capitalizeTotalAmount = RMBConverter.numberToChinese(
                        sums[index]
                    );
                }
            } else {
                sums[index] = "";
            }
        }
    });
}

/** 下拉选择公共方法 */
export function getRemoteList(query, loading, option, optionKey, fetchFn, optionsRef) {
    if (query) {
        loading.value = true;
        setTimeout(() => {
            option.value[optionKey] = query;
            fetchFn(option.value).then((response) => {
                optionsRef.value = response.rows;
                loading.value = false;
            });
        }, 200);
    } else {
        fetchFn(option.value).then((response) => {
            optionsRef.value = response.rows;
        });
    }
}

/** 仓库名称下拉选择 */
export function getRemoteWarehouse(query, loading, option, warehouseOptions) {
    getRemoteList(query, loading, option, 'warehouseName', warehouseList, warehouseOptions);
}

/** 供应商名称下拉选择 */
export function getRemoteSupplier(query, loading, option, supplierOptions) {
    getRemoteList(query, loading, option, 'supplierName', supplierList, supplierOptions);
}

/** 客户名称下拉选择 */
export function getRemoteCustomer(query, loading, option, customerOptions) {
    getRemoteList(query, loading, option, 'customerName', customerList, customerOptions);
}

/** 货品编号|名称下拉选择 */
export function getRemoteProduct(query, searchField, loading, option, productOptions) {
    getRemoteList(query, loading, option, searchField, inventoryList, productOptions);
}

export function selectAllInventoryQuery(productId, inventoryForm) {
    productBatch.value.productId = productId;
    selectInventoryQtyQuery(productBatch.value).then((response) => {
        inventoryForm.value = response.rows;
    });
}