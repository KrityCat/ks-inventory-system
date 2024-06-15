<template>
  <!-- 库存货品查询 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          v-show="showSearch"
          ref="queryRef"
          :model="queryParams"
          label-width="100px"
        >
          <el-form-item label="货品编号" prop="productCode">
            <el-input
              v-model="queryParams.productCode"
              placeholder="请输入货品编号"
              clearable
              style="width: 200px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
              v-model="queryParams.productName"
              placeholder="请输入货品名称"
              clearable
              style="width: 200px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品类型" prop="productType">
            <el-tree-select
              style="width: 200px"
              v-model="form.productType"
              :data="typeOptions"
              :props="{ value: 'id', label: 'label', children: 'children' }"
              value-key="id"
              placeholder="请选择货品类型"
              clearable
              check-strictly
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="productSpecifications">
            <el-input
              v-model="queryParams.productSpecifications"
              placeholder="请输入商品规格"
              clearable
              style="width: 200px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="仓库" prop="warehousingId">
            <el-select
              style="width: 200px"
              v-model="queryParams.warehousingId"
              placeholder="请选择"
            >
              <el-option
                v-for="item in warehouseOptions"
                :key="item.warehouseId"
                :label="item.warehouseName"
                :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              icon="Search"
              @click="handleQuery"
              v-hasPermi="['system:inventoryItemInquiry:list']"
              >查询</el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="Download"
              @click="handleDetailExport"
              v-hasPermi="['system:inventoryItemInquiry:export']"
              >导出</el-button
            >
          </el-col>
          <right-toolbar
            v-model:showSearch="showSearch"
            @queryTable="getList"
            :columns="columns"
          ></right-toolbar>
        </el-row>

        <el-table border v-loading="loading" :data="inventoryItemInquiryList">
          <el-table-column
            label="序号"
            align="center"
            type="index"
            width="60"
          />
          <el-table-column
            label="货品编号"
            align="center"
            prop="product.productCode"
            v-if="columns[0].visible"
          />
          <el-table-column
            label="货品名称"
            align="center"
            prop="product.productName"
            v-if="columns[1].visible"
          />
          <el-table-column
            label="货品类型"
            align="center"
            prop="type.productTypeName"
            v-if="columns[2].visible"
          />
          <el-table-column
            label="规格"
            align="center"
            prop="product.productSpecifications"
            v-if="columns[3].visible"
          />
          <el-table-column
            label="单位"
            align="center"
            prop="product.measureUnit"
            v-if="columns[4].visible"
          />
          <el-table-column
            label="产地"
            align="center"
            prop="product.producer"
            v-if="columns[5].visible"
          />
          <el-table-column
            label="仓库"
            align="center"
            prop="warehouse.warehouseName"
            v-if="columns[6].visible"
          />
          <el-table-column
            label="数量"
            align="center"
            prop="planQuantity"
            v-if="columns[7].visible"
          />
          <el-table-column
            label="单价"
            align="center"
            prop="univalence"
            v-if="columns[8].visible"
          />
          <el-table-column
            label="金额"
            align="center"
            prop="money"
            v-if="columns[10].visible"
          />
        </el-table>
        <!-- 分页组件 -->
        <pagination
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
        />
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="InventoryItemInquiry">
import { listWarehouse } from "@/api/basedate/warehouse";
import { selectInventoryItemInquiry } from "@/api/inventory/InventoryItemInquiry";
import { productTypeTreeSelect } from "@/api/basedate/product";

const { proxy } = getCurrentInstance();

// 查询结果表
const inventoryItemInquiryList = ref([]);
// 仓库列表
const warehouseOptions = ref(undefined);
// 隐藏查询
const showSearch = ref(true);
// 加载
const loading = ref(true);
// 总条数
const total = ref(0);
// 数据范围
const dateRange = ref([]);
// 货品类型列表
const typeOptions = ref(undefined);
// 列显隐信息
const columns = ref([
  { key: 0, label: `货品编号`, visible: true },
  { key: 1, label: `货品名称`, visible: true },
  { key: 2, label: `货品类型`, visible: true },
  { key: 3, label: `规格`, visible: true },
  { key: 4, label: `单位`, visible: true },
  { key: 5, label: `产地`, visible: true },
  { key: 6, label: `仓库`, visible: true },
  { key: 7, label: `数量`, visible: true },
  { key: 8, label: `单价`, visible: true },
  { key: 9, label: `金额`, visible: true },
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    warehouseId: undefined,
  },
});

const { queryParams, form } = toRefs(data);

function Options() {
  listWarehouse().then((response) => {
    warehouseOptions.value = response.rows;
  });
  productTypeTreeSelect().then((response) => {
    typeOptions.value = response.data;
  });
}
/** 查询库存明细列表 */
function getList() {
  loading.value = true;
  selectInventoryItemInquiry(
    proxy.addDateRange(queryParams.value, dateRange.value)
  ).then((response) => {
    inventoryItemInquiryList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}
/** 查询按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}
/** 重置按钮操作 */
function resetQuery() {
  typeOptions.value = undefined;
  dateRange.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
  reset();
}
/** 重置操作表单 */
function reset() {
  form.value = {
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    warehouseId: undefined,
  };
  proxy.resetForm("queryRef");
}
/** 明细导出按钮操作 */
function handleDetailExport() {
  proxy.download(
    "system/inventoryItemInquiry/export",
    {
      ...queryParams.value,
    },
    `库存货品表_${new Date().getTime()}.xlsx`
  );
}
getList();
Options();
</script>
