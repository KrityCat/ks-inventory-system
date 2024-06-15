<template>
  <!-- 库存发生明细 -->
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
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
              v-model="queryParams.productName"
              placeholder="请输入货品名称"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品类型" prop="productType">
            <el-tree-select
              style="width: 180px"
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
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="仓库" prop="warehousingId">
            <el-select
              style="width: 180px"
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
              v-hasPermi="['system:inventoryOccurrenceDetails:list']"
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
              disable="disable"
              v-hasPermi="['system:inventoryOccurrenceDetails:export']"
              >导出</el-button
            >
          </el-col>
          <right-toolbar
              v-model:showSearch="showSearch"
              @queryTable="getList"
            ></right-toolbar>
        </el-row>

        <el-table
          border
          show-summary
          v-loading="loading"
          :data="occurrenceDetailList"
        >
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
          />
          <el-table-column
            label="货品名称"
            align="center"
            prop="product.productName"
          />
          <el-table-column
            label="货品类型"
            align="center"
            prop="type.productTypeName"
          />
          <el-table-column
            label="规格"
            align="center"
            prop="product.productSpecifications"
          />
          <el-table-column
            label="单位"
            align="center"
            prop="product.measureUnit"
          />
          <el-table-column label="期初结存" align="center">
            <el-table-column
              label="数量"
              align="center"
              prop="obplanQuantity"
            />
            <el-table-column
              label="单价"
              align="center"
              prop="obunivalence"
            />
            <el-table-column 
              label="金额" 
              align="center" 
              prop="obmoney" 
            />
          </el-table-column>
          <el-table-column label="业务类型" align="center" prop="headReceipt.receiptType" />
          <el-table-column label="开单日期" align="center" prop="headReceipt.invoiceDate" />
          <el-table-column label="系统单号" align="center" prop="headReceipt.systematicReceipt" />
          <el-table-column label="原始单号" align="center" prop="headReceipt.originalReceipt" />
          <el-table-column label="供应商" align="center" prop="supplier.supplierName" />
          <el-table-column label="客户" align="center" prop="customer.customerName" />
          <el-table-column label="数量" align="center" prop="planQuantity" />
          <el-table-column label="单价" align="center" prop="univalence" />
          <el-table-column label="金额" align="center" prop="money" />
          <el-table-column label="创建日期" align="center" prop="headReceipt.createDate" />
          <el-table-column label="期末结存" align="center">
            <el-table-column
              label="数量"
              align="center"
              prop="cbplanQuantity"
            />
            <el-table-column
              label="单价"
              align="center"
              prop="cbunivalence"
            />
            <el-table-column 
              label="金额" 
              align="center" 
              prop="cbmoney" 
            />
          </el-table-column>
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

<script setup name="InventoryOccurrenceDetails">
import { listWarehouse } from "@/api/basedate/warehouse";
import { occurrenceDetailsQuery } from "@/api/inventory/inventoryOccurrenceDetails";
import { productTypeTreeSelect } from "@/api/basedate/product";

const { proxy } = getCurrentInstance();

// 查询结果表
const occurrenceDetailList = ref([]);
const warehouseOptions = ref(undefined);
// 隐藏查询
const showSearch = ref(true);
// 加载
const loading = ref(true);
// 总条数
const total = ref(0);
// 数据范围
const dateRange = ref([]);
const typeOptions = ref(undefined);

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
  rules: {},
});

const { queryParams, form, rules } = toRefs(data);

function Options() {
  listWarehouse().then((response) => {
    warehouseOptions.value = response.rows;
  });
  productTypeTreeSelect().then((response) => {
    typeOptions.value = response.data;
  });
}
/** 库存发生明细列表 */
function getList() {
  loading.value = true;
  occurrenceDetailsQuery(
    proxy.addDateRange(queryParams.value, dateRange.value)
  ).then((response) => {
    occurrenceDetailList.value = response.rows;
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
/** 导出按钮操作 */
function handleDetailExport() {
  proxy.download(
    "system/inventoryOccurrenceDetails/export",
    {
      ...queryParams.value,
    },
    `库存发生明细表_${new Date().getTime()}.xlsx`
  );
}
getList();
Options();
</script>
