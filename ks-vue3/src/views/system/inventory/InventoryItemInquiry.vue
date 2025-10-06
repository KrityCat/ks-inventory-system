<template>
  <!-- 库存货品查询 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
            v-show="showSearch"
            ref="queryRef"
            :inline="true"
            :model="queryParams"
            label-width="100px"
        >
          <el-form-item label="货品编号" prop="productCode">
            <el-input
                v-model="queryParams.productCode"
                class="form-item"
                clearable
                placeholder="请输入货品编号"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
                v-model="queryParams.productName"
                class="form-item"
                clearable
                placeholder="请输入货品名称"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品类型" prop="productType">
            <el-tree-select
                v-model="form.productType"
                :data="typeOptions"
                :props="{ value: 'id', label: 'label', children: 'children' }"
                check-strictly
                class="form-item"
                clearable
                placeholder="请选择货品类型"
                value-key="id"
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="productSpecifications">
            <el-input
                v-model="queryParams.productSpecifications"
                class="form-item"
                clearable
                placeholder="请输入商品规格"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="仓库" prop="warehouseId">
            <el-select
                v-model="queryParams.warehouseId"
                class="form-item"
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
                v-hasPermi="['inventory:inventoryItemInquiry:list']"
                icon="Search"
                type="primary"
                @click="handleQuery"
            >查询
            </el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['inventory:inventoryItemInquiry:export']"
                icon="Download"
                plain
                type="danger"
                @click="handleDetailExport"
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

        <el-table v-loading="loading" :data="inventoryItemInquiryList" border>
          <el-table-column
              align="center"
              label="序号"
              type="index"
              width="60"
          />
          <el-table-column
              v-if="columns[0].visible"
              align="center"
              label="货品编号"
              prop="product.productCode"
          />
          <el-table-column
              v-if="columns[1].visible"
              align="center"
              label="货品名称"
              prop="product.productName"
          />
          <el-table-column
              v-if="columns[2].visible"
              align="center"
              label="货品类型"
              prop="type.productTypeName"
          />
          <el-table-column
              v-if="columns[3].visible"
              align="center"
              label="规格"
              prop="product.productSpecifications"
          />
          <el-table-column
              v-if="columns[4].visible"
              align="center"
              label="单位"
              prop="product.measureUnit"
          />
          <el-table-column
              v-if="columns[5].visible"
              align="center"
              label="产地"
              prop="product.producer"
          />
          <el-table-column
              v-if="columns[6].visible"
              align="center"
              label="仓库"
              prop="warehouse.warehouseName"
          />
          <el-table-column
              v-if="columns[7].visible"
              align="center"
              label="数量"
              prop="planQuantity"
          />
          <el-table-column
              v-if="columns[8].visible"
              align="center"
              label="单价"
              prop="univalence"
          />
          <el-table-column
              v-if="columns[9].visible"
              align="center"
              label="金额"
              prop="money"
          />
        </el-table>
        <!-- 分页组件 -->
        <pagination
            v-show="total > 0"
            v-model:limit="queryParams.pageSize"
            v-model:page="queryParams.pageNum"
            :total="total"
            @pagination="getList"
        />
      </el-col>
    </el-row>
  </div>
</template>

<script name="InventoryItemInquiry" setup>
import {listWarehouse} from "@/api/basedate/warehouse";
import {selectInventoryItemInquiry} from "@/api/inventory/InventoryItemInquiry";
import {productTypeTreeSelect} from "@/api/basedate/product";

const {proxy} = getCurrentInstance();

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
  {key: 0, label: `货品编号`, visible: true},
  {key: 1, label: `货品名称`, visible: true},
  {key: 2, label: `货品类型`, visible: true},
  {key: 3, label: `规格`, visible: true},
  {key: 4, label: `单位`, visible: true},
  {key: 5, label: `产地`, visible: true},
  {key: 6, label: `仓库`, visible: true},
  {key: 7, label: `数量`, visible: true},
  {key: 8, label: `单价`, visible: true},
  {key: 9, label: `金额`, visible: true},
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    warehouseId: undefined,
  },
});

const {queryParams, form} = toRefs(data);

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
      "inventory/inventoryItemInquiry/export",
      {
        ...queryParams.value,
      },
      `库存货品表_${new Date().getTime()}.xlsx`
  );
}

getList();
Options();
</script>

<style scoped>
.form-item {
  width: 200px;
}
</style>