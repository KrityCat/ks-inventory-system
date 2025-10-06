<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--查询条件-->
      <el-col :span="24" :xs="24">
        <el-form
            v-show="showSearch"
            ref="queryRef"
            :inline="true"
            :model="queryParams"
            label-width="90px"
        >
          <el-form-item label="配件编号" prop="accessoryCode">
            <el-input
                v-model="queryParams.accessoryCode"
                clearable
                placeholder="请输入配件编号"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="配件名称" prop="accessoryName">
            <el-input
                v-model="queryParams.accessoryName"
                clearable
                placeholder="请输入配件名称"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="accessorySpecifications">
            <el-input
                v-model="queryParams.accessorySpecifications"
                clearable
                placeholder="请输入商品规格"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="创建时间" style="width: 308px">
            <el-date-picker
                v-model="dateRange"
                end-placeholder="结束日期"
                range-separator="-"
                start-placeholder="开始日期"
                type="daterange"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button icon="Search" type="primary" @click="handleQuery"
            >搜索
            </el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:add']"
                icon="Plus"
                plain
                type="primary"
                @click="handleAdd"
            >新增
            </el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:export']"
                icon="Download"
                plain
                type="warning"
                @click="handleExport"
            >导出
            </el-button
            >
          </el-col>
          <right-toolbar
              v-model:showSearch="showSearch"
              :columns="columns"
              @queryTable="getList"
          ></right-toolbar>
        </el-row>

        <el-table
            v-loading="loading"
            :data="productList"
            border
        >
          <el-table-column
              align="center"
              label="序号"
              type="index"
              width="60"
          />
          <el-table-column
              v-if="columns[0].visible"
              key="accessoryCode"
              align="center"
              label="配件编号"
              prop="accessoryCode"
          />
          <el-table-column
              v-if="columns[1].visible"
              key="accessoryName"
              align="center"
              label="配件名称"
              prop="accessoryName"
              width="250"
          />
          <el-table-column
              v-if="columns[2].visible"
              key="accessoryType"
              align="center"
              label="配件类型"
              prop="accessoryType"
              width="100"
          />
          <el-table-column
              v-if="columns[3].visible"
              key="accessorySpecifications"
              align="center"
              label="商品规格"
              prop="accessorySpecifications"
          />
          <el-table-column
              v-if="columns[4].visible"
              key="measureUnit"
              align="center"
              label="计量单位"
              prop="measureUnit"
          />
          <el-table-column
              v-if="columns[5].visible"
              key="producer"
              align="center"
              label="产地"
              prop="producer"
          />
          <el-table-column
              v-if="columns[6].visible"
              key="inventoryQty"
              align="center"
              label="库存数量"
              prop="inventoryQty"
          />
          <el-table-column
              v-if="columns[7].visible"
              key="status"
              align="center"
              label="状态"
          >
            <template #default="scope">
              <dict-tag
                  :options="sys_normal_disable"
                  :value="scope.row.status"
              />
            </template>
          </el-table-column>
          <el-table-column
              v-if="columns[8].visible"
              key="notes"
              align="center"
              label="备注"
              prop="notes"
          />
          <el-table-column
              v-if="columns[9].visible"
              align="center"
              label="创建者"
              prop="createBy"
          />
          <el-table-column
              v-if="columns[10].visible"
              align="center"
              label="创建时间"
              prop="createTime"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
              v-if="columns[11].visible"
              align="center"
              label="更新者"
              prop="updateBy"
          />
          <el-table-column
              v-if="columns[12].visible"
              :show-overflow-tooltip="true"
              align="center"
              label="更新时间"
              prop="updateTime"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
              align="center"
              class-name="small-padding fixed-width"
              fixed="right"
              label="操作"
              width="100"
          >
            <template #default="scope">
              <el-tooltip content="修改" placement="top">
                <el-button
                    v-hasPermi="['baseDate:product:update']"
                    icon="Edit"
                    link
                    type="primary"
                    @click="handleUpdate(scope.row)"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                    v-hasPermi="['baseDate:product:remove']"
                    icon="Delete"
                    link
                    type="primary"
                    @click="handleDelete(scope.row)"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="操作记录">
                <el-button
                    icon="Memo"
                    link
                    type="primary"
                    @click="handleRecord(scope.row)"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <pagination
            v-show="total > 0"
            v-model:limit="queryParams.pageSize"
            v-model:page="queryParams.pageNum"
            :total="total"
            @pagination="getList"
        />
      </el-col>
    </el-row>

    <!-- 添加或修改配件资料配置对话框 -->
    <el-dialog v-model="open" :title="title" append-to-body width="700px">
      <el-form ref="productRef" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="配件编号" prop="accessoryCode">
              <el-select
                  v-model="form.accessoryCode"
                  :disabled="codeSelect"
                  :loading="loading"
                  :remote-method="remoteProductCode"
                  filterable
                  placeholder="请输入配件编号"
                  remote
                  remote-show-suffix
                  @change="changeProduct($event)"
              >
                <el-option
                    v-for="item in productOptions"
                    :key="item.productId"
                    :label="item.productCode"
                    :value="item.productId"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="配件名称" prop="accessoryName">
              <el-input v-model="form.accessoryName" disabled/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="配件类型" prop="accessoryType">
              <el-input v-model="form.accessoryType" disabled/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="配件规格" prop="accessorySpecifications">
              <el-input v-model="form.accessorySpecifications" disabled/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="计量单位" prop="measureUnit">
              <el-input v-model="form.measureUnit" disabled/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="库存数量" prop="costPrice">
              <el-input v-model="form.inventoryQty"/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="产地" prop="producer">
              <el-input v-model="form.producer" disabled/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-radio-group v-model="form.status">
                <el-radio
                    v-for="dict in sys_normal_disable"
                    :key="dict.value"
                    :label="dict.value"
                >{{ dict.label }}
                </el-radio
                >
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input
                  v-model="form.notes"
                  placeholder="请输入内容"
                  type="textarea"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 查看配件修改记录对话框 -->
    <el-dialog
        v-model="openRecord"
        :title="titleRecord"
        append-to-body
        width="80%"
    >
      <el-table v-loading="loading" :data="documentOperationRecordList">
        <el-table-column
            align="center"
            label="序号"
            type="index"
            width="60"
        />
        <el-table-column
            key="accessoryCode"
            align="center"
            label="配件编号"
            prop="accessoryCode"
        />
        <el-table-column
            key="accessoryName"
            align="center"
            label="配件名称"
            prop="accessoryName"
            width="250"
        />
        <el-table-column
            key="accessoryType"
            align="center"
            label="配件类型"
            prop="accessoryType"
            width="100"
        />
        <el-table-column
            key="accessorySpecifications"
            align="center"
            label="商品规格"
            prop="accessorySpecifications"
        />
        <el-table-column
            key="measureUnit"
            align="center"
            label="计量单位"
            prop="measureUnit"
        />
        <el-table-column
            key="producer"
            align="center"
            label="产地"
            prop="producer"
        />
        <el-table-column
            key="inventoryQty"
            align="center"
            label="库存数量"
            prop="inventoryQty"
        />
        <el-table-column
            key="status"
            align="center"
            label="状态"
        >
          <template #default="scope">
            <dict-tag
                :options="sys_normal_disable"
                :value="scope.row.status"
            />
          </template>
        </el-table-column>
        <el-table-column
            key="notes"
            align="center"
            label="备注"
            prop="notes"
        />
        <el-table-column
            v-if="columns[11].visible"
            align="center"
            label="更新者"
            prop="updateBy"
        />
        <el-table-column
            align="center"
            label="更新时间"
            prop="updateTime"
        >
          <template #default="scope">
            <span>{{ parseTime(scope.row.updateTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>

  </div>
</template>

<script name="AccessoryQuery" setup>
import {
  addAccessory,
  addAccessoryRecord,
  delAccessory,
  getAccessory,
  listAccessory,
  listRecord,
  updateAccessory,
} from "@/api/inventory/accessory";
import {getRemoteProduct} from "@/utils/processingUtils";

const {proxy} = getCurrentInstance();
const {sys_normal_disable} = proxy.useDict("sys_normal_disable");

const productList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const total = ref(0);
const title = ref("");
const dateRange = ref([]);
const documentOperationRecordList = ref([]);
const titleRecord = ref("");
const openRecord = ref(false);
const codeSelect = ref(false);

// 列显隐信息
const columns = ref([
  {key: 0, label: `配件编号`, visible: true},
  {key: 1, label: `配件名称`, visible: true},
  {key: 2, label: `配件类型`, visible: true},
  {key: 3, label: `配件规格`, visible: true},
  {key: 4, label: `计量单位`, visible: true},
  {key: 5, label: `产地`, visible: true},
  {key: 6, label: `库存数量`, visible: true},
  {key: 7, label: `状态`, visible: true},
  {key: 8, label: `备注`, visible: true},
  {key: 9, label: `创建者`, visible: true},
  {key: 10, label: `创建时间`, visible: true},
  {key: 11, label: `更新者`, visible: true},
  {key: 12, label: `更新时间`, visible: true},
]);

const data = reactive({
  productOptions: undefined,
  option: {
    warehouseId: undefined,
    warehouseName: undefined,
    supplierId: undefined,
    supplierName: undefined,
    customerId: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  },
  form: {
    accessoryId: undefined,
    accessoryCode: undefined,
    accessoryName: undefined,
    accessoryType: undefined,
    accessorySpecifications: undefined,
    measureUnit: undefined,
    producer: undefined,
    inventoryQty: undefined,
    notes: undefined,
    status: undefined,
  },
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    accessoryId: undefined,
    accessoryCode: undefined,
    accessoryName: undefined,
    accessoryType: undefined,
    accessorySpecifications: undefined,
    measureUnit: undefined,
    producer: undefined,
    notes: undefined,
    status: undefined,
  },
  selectParams: {
    pageNum: 1,
    pageSize: 50,
    accessoryCode: undefined,
  },
  recordParams: {
    pageNum: 1,
    pageSize: 50,
    accessoryId: undefined,
  },
  rules: {
    accessoryCode: [
      {required: true, message: "配件编号不能为空", trigger: "blur"},
    ],
  },
});

const {productOptions, option, queryParams, selectParams, recordParams, form, rules} = toRefs(data);

/** 查询配件列表 */
function getList() {
  loading.value = true;
  listAccessory(proxy.addDateRange(queryParams.value, dateRange.value)).then(
      (res) => {
        loading.value = false;
        productList.value = res.rows;
        total.value = res.total;
      }
  );
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  dateRange.value = [];
  proxy.resetForm("queryRef");
  queryParams.value.accessoryType = undefined;
  proxy.$refs.typeTreeRef.setCurrentKey(null);
  handleQuery();
}

/** 删除按钮操作 */
function handleDelete(row) {
  const accessoryCodes = row.accessoryCode || ids.value;
  const accessoryIds = row.accessoryId || ids.value;
  proxy.$modal
      .confirm('是否确认删除编号为"' + accessoryCodes + '"的配件？')
      .then(function () {
        return delAccessory(accessoryIds);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess("删除成功");
      })
      .catch(() => {
      });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download(
      "inventory/accessory/export",
      {
        ...queryParams.value,
      },
      `配件资料_${new Date().getTime()}.xlsx`
  );
}

/** 重置操作表单 */
function reset() {
  form.value = {
    accessoryCode: undefined,
    accessoryName: undefined,
    accessoryType: undefined,
    accessorySpecifications: undefined,
    measureUnit: undefined,
    producer: undefined,
    notes: undefined,
    inventoryQty: undefined,
    status: "0",
  };
  proxy.resetForm("productRef");
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加配件";
  codeSelect.value = false;
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const accessoryId = row.accessoryId || ids.value;
  getAccessory(accessoryId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改配件";
    codeSelect.value = true;
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["productRef"].validate((valid) => {
    if (valid) {
      if (form.value.accessoryId !== undefined) {
        updateAccessory(form.value).then(() => {
        });
        addAccessoryRecord(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        selectParams.value.accessoryCode = form.value.accessoryCode
        listAccessory(selectParams.value).then((response) => {
          if (response.rows?.length) {
            proxy.$modal.msgError("不能新增一样配件");
            selectParams.value.accessoryCode = null;
          } else {
            addAccessory(form.value).then(() => {
            });
            addAccessoryRecord(form.value).then(() => {
              proxy.$modal.msgSuccess("新增成功");
              open.value = false;

              getList();
            });
          }
        });
      }
    }
  });
}

// 选择货品
function changeProduct(selectedProductId) {
  const selectedProduct = productOptions.value.find(
      item => item.productId === selectedProductId
  );

  if (!selectedProduct) {
    proxy.$modal.msgError("未找到对应配件信息");
    return;
  }

  // 只更新必要字段，避免覆盖其他数据
  form.value = {
    ...form.value, // 保留原有字段
    accessoryCode: selectedProduct.productCode,
    accessoryName: selectedProduct.productName,
    accessoryType: selectedProduct.productTypeName,
    accessorySpecifications: selectedProduct.productSpecifications,
    measureUnit: selectedProduct.measureUnit,
    producer: selectedProduct.producer,
    inventoryQty: "0",
    status: "0",
    // 保持原notes值
    notes: form.value.notes
  };
}

/** 操作记录按钮操作 */
function handleRecord(row) {
  recordParams.value.accessoryId = row.accessoryId;
  listRecord(recordParams.value).then((response) => {
    documentOperationRecordList.value = response.rows;
    total.value = response.total;
    openRecord.value = true;
    titleRecord.value = "配件操作记录";
  });
}

// 查询货品编号
function remoteProductCode(query) {
  optionReset();
  getRemoteProduct(query, "productCode", loading, option, productOptions);
}

/** 重置下拉框表单 */
function optionReset() {
  option.value = {
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  };
}

getList();
</script>
