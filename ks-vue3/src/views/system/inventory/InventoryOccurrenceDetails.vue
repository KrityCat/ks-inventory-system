<template>
  <!-- 库存发生明细 -->
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
          <el-form-item label="发生时间" style="width: 388px">
            <el-date-picker
                v-model="dateRange"
                end-placeholder="结束日期"
                range-separator="-"
                start-placeholder="开始日期"
                type="daterange"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="货品编号" prop="productCode">
            <el-input
                v-model="queryParams.productCode"
                clearable
                placeholder="请输入货品编号"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
                v-model="queryParams.productName"
                clearable
                placeholder="请输入货品名称"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品类型" prop="productType">
            <el-tree-select
                v-model="form.productType"
                :data="typeOptions"
                :props="{ value: 'id', label: 'label', children: 'children' }"
                check-strictly
                clearable
                placeholder="请选择货品类型"
                style="width: 180px"
                value-key="id"
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="productSpecifications">
            <el-input
                v-model="queryParams.productSpecifications"
                clearable
                placeholder="请输入商品规格"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="仓库" prop="warehousingId">
            <el-select
                v-model="queryParams.warehousingId"
                placeholder="请选择"
                style="width: 180px"
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
                v-hasPermi="['inventory:inventoryOccurrenceDetails:list']"
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
          <!-- <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="Download"
              @click="handleDetailExport"
              disable="disable"
              v-hasPermi="['system:inventoryOccurrenceDetails:export']"
              >导出</el-button
            >
          </el-col> -->
          <right-toolbar
              v-model:showSearch="showSearch"
              @queryTable="getList"
          ></right-toolbar>
        </el-row>

        <el-table
            v-loading="loading"
            :data="occurrenceDetailList"
            border
            show-summary
        >
          <el-table-column
              align="center"
              label="序号"
              type="index"
              width="60"
          />
          <el-table-column
              align="center"
              label="货品编号"
              prop="product.productCode"
          />
          <el-table-column
              align="center"
              label="货品名称"
              prop="product.productName"
          />
          <el-table-column
              align="center"
              label="货品类型"
              prop="type.productTypeName"
          />
          <el-table-column
              align="center"
              label="规格"
              prop="product.productSpecifications"
          />
          <el-table-column
              align="center"
              label="单位"
              prop="product.measureUnit"
          />
          <el-table-column
              align="center"
              label="业务类型"
              prop="receiptType"
              width="100"
          >
            <template #default="scope">
              <dict-tag
                  :options="receipt_type"
                  :value="scope.row.receiptType"
              />
            </template>
          </el-table-column>
          <el-table-column
              align="center"
              label="开单日期"
              prop="headReceipt.invoiceDate"
              width="100"
          />
          <el-table-column
              align="center"
              label="系统单号"
              prop="systematicReceipt"
              width="180"
          >
            <template #default="scope">
              <el-link type="primary">
                <a target="_blank" @click="handleUpdate(scope.row)">{{
                    scope.row.systematicReceipt
                  }}</a>
              </el-link>
            </template>
          </el-table-column>
          <el-table-column
              align="center"
              label="原始单号"
              prop="headReceipt.originalReceipt"
          />
          <el-table-column
              align="center"
              idth="100"
              label="供应商"
              prop="supplier.supplierName"
          />
          <el-table-column
              align="center"
              idth="100"
              label="客户"
              prop="customer.customerName"
          />
          <el-table-column align="center" label="数量" prop="planQuantity"/>
          <el-table-column align="center" label="单价" prop="univalence"/>
          <el-table-column align="center" label="金额" prop="money"/>
          <el-table-column
              align="center"
              label="创建日期"
              prop="headReceipt.createTime"
              width="180"
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

<script name="InventoryOccurrenceDetails" setup>
import {listWarehouse} from "@/api/basedate/warehouse";
import {occurrenceDetailsQuery} from "@/api/inventory/inventoryOccurrenceDetails";
import {productTypeTreeSelect} from "@/api/basedate/product";
import {useRouter} from "vue-router";

const {proxy} = getCurrentInstance();
const {receipt_type} = proxy.useDict("receipt_type");

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
const router = useRouter();

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
  rules: {},
});

const {queryParams, form, rules} = toRefs(data);

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
      "inventory/inventoryOccurrenceDetails/export",
      {
        ...queryParams.value,
      },
      `库存发生明细表_${new Date().getTime()}.xlsx`
  );
}

function handleUpdate(row) {
  const systematicReceipt = row.systematicReceipt;
  const receiptType = row.receiptType;

  // 路由配置对象
  const routeMap = {
    1: "/purchase/purchaseDocumentProcessing",
    2: "/purchase/purchaseDocumentProcessing",
    3: "/sales/salesDocumentProcessing",
    4: "/sales/salesDocumentProcessing",
    5: "/inventory/inventoryDocumentProcessing",
    6: "/inventory/inventoryDocumentProcessing",
    7: "/inventory/inventoryTransfer",
    8: "/inventory/inventoryCounting",
    9: "/inventory/reportingLossesProcessing",
    10: "/inventory/reportOverflowProcessing",
    11: "/inventory/assemblyAndDisassemblyProcessing",
  };

  // 获取对应的路径
  const path = routeMap[receiptType];

  // 如果路径存在，则进行导航
  if (path) {
    router.push({
      path: path,
      query: {systematicReceipt},
    });
  } else {
    return proxy.$modal.msgError("该单据类型不存在制作页面");
  }
}

getList();
Options();
</script>
