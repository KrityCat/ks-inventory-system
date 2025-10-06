<template>
  <div>
    <el-row
      :gutter="2"
      v-hasPermi="['index:salesAmountQuery']"
    >
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>销售总金额</span>
            </div>
          </template>
          <el-row>
            <el-col :span="4">
              <el-statistic title="当天" :value="dailySalesAmount" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="近1个月" :value="lastMonthSalesAmount" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="近半年" :value="lastSixMonthsSalesAmount" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="今年" :value="thisYearSalesAmount" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="上一年" :value="lastYearSalesAmount" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="上上一年" :value="lastTwoYearsSalesAmount" />
            </el-col>
          </el-row>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>毛利润</span>
            </div>
          </template>
          <el-row>
            <el-col :span="4">
              <el-statistic title="当天" :value="dailyGrossProfit" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="近1个月" :value="lastMonthGrossProfit" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="近半年" :value="lastSixMonthsGrossProfit" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="今年" :value="thisYearGrossProfit" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="上一年" :value="lastYearGrossProfit" />
            </el-col>
            <el-col :span="4">
              <el-statistic title="上上一年" :value="lastTwoYearsGrossProfit" />
            </el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
    <el-row
      :gutter="5"
      v-hasPermi="['index:salesNotTakeEffectQuery']"
    >
      <el-col :span="24">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>待审核</span>
            </div>
          </template>
          <el-row>
            <el-col :span="3">
              <el-statistic title="采购入库单据" :value="purchaseInReceipt" />
            </el-col>
            <el-col :span="3">
              <el-statistic title="采购退库单据" :value="purchaseOutReceipt" />
            </el-col>
            <el-col :span="3">
              <el-statistic title="销售出库单据" :value="salesOutReceipt" />
            </el-col>
            <el-col :span="3">
              <el-statistic title="销售退库单据" :value="salesRefundReceipt" />
            </el-col>
            <el-col :span="3">
              <el-statistic title="其他入库单据" :value="otherInReceipt" />
            </el-col>
            <el-col :span="3">
              <el-statistic title="其他出库单据" :value="otherOutReceipt" />
            </el-col>
            <el-col :span="3">
              <el-statistic
                title="库存调拨单据"
                :value="otherTransferReceipt"
              />
            </el-col>
            <el-col :span="3">
              <el-statistic title="库存盘点单据" :value="stocktakingReceipt" />
            </el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="2">
      <el-col :span="12" v-hasPermi="['index:overstockList']">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>货品库存预警</span>
            </div>
          </template>
          <el-tabs tab-position="left" style="height: 500px" class="demo-tabs">
            <el-tab-pane label="积压"
              ><el-table
                border
                v-loading="loading"
                :data="overstockProductList"
              >
                <el-table-column
                  label="货品编号"
                  align="center"
                  key="productCode"
                  prop="productCode"
                />
                <el-table-column
                  label="货品名称"
                  align="center"
                  key="productName"
                  prop="productName"
                  width="250"
                />
                <el-table-column
                  label="货品类型"
                  align="center"
                  key="productTypeName"
                  prop="type.productTypeName"
                  width="100"
                />
                <el-table-column
                  label="库存数量"
                  align="center"
                  key="inventoryQty"
                  prop="inventoryQty"
                />
                <el-table-column
                  label="库存上限"
                  align="center"
                  key="upperLimit"
                  prop="upperLimit"
                /> </el-table
            ></el-tab-pane>
            <el-tab-pane label="不足"
              ><el-table
                border
                v-loading="loading"
                :data="dangerProductList"
                height="500"
              >
                <el-table-column
                  label="货品编号"
                  align="center"
                  key="productCode"
                  prop="productCode"
                />
                <el-table-column
                  label="货品名称"
                  align="center"
                  key="productName"
                  prop="productName"
                  width="250"
                />
                <el-table-column
                  label="货品类型"
                  align="center"
                  key="productTypeName"
                  prop="type.productTypeName"
                  width="100"
                />
                <el-table-column
                  label="库存数量"
                  align="center"
                  key="inventoryQty"
                  prop="inventoryQty"
                />
                <el-table-column
                  label="库存下限"
                  align="center"
                  key="lowerLimit"
                  prop="lowerLimit"
                /> </el-table
            ></el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
      <el-col :span="12" v-hasPermi="['index:monthOverstockList']">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>货品库存未出库时间预警</span>
            </div>
          </template>
          <el-tabs tab-position="left" style="height: 500px" class="demo-tabs">
            <el-tab-pane label="3个月"
              ><el-table
                border
                v-loading="loading"
                :data="threeOverstockList"
                height="500"
              >
                <el-table-column
                  label="货品编号"
                  align="center"
                  key="productCode"
                  prop="productCode" />
                <el-table-column
                  label="货品名称"
                  align="center"
                  key="productName"
                  prop="productName"
                  width="250" />
                <el-table-column
                  label="货品类型"
                  align="center"
                  key="productTypeName"
                  prop="type.productTypeName"
                  width="100" />
                <el-table-column
                  label="库存数量"
                  align="center"
                  key="inventoryQty"
                  prop="inventoryQty" /></el-table
            ></el-tab-pane>
            <el-tab-pane label="6个月"
              ><el-table
                border
                v-loading="loading"
                :data="sixOverstockList"
                height="500"
              >
                <el-table-column
                  label="货品编号"
                  align="center"
                  key="productCode"
                  prop="productCode" />
                <el-table-column
                  label="货品名称"
                  align="center"
                  key="productName"
                  prop="productName"
                  width="250" />
                <el-table-column
                  label="货品类型"
                  align="center"
                  key="productTypeName"
                  prop="type.productTypeName"
                  width="100" />
                <el-table-column
                  label="库存数量"
                  align="center"
                  key="inventoryQty"
                  prop="inventoryQty" /></el-table
            ></el-tab-pane>
            <el-tab-pane label="1年"
              ><el-table
                border
                v-loading="loading"
                :data="twelveOverstockList"
                height="500"
              >
                <el-table-column
                  label="货品编号"
                  align="center"
                  key="productCode"
                  prop="productCode" />
                <el-table-column
                  label="货品名称"
                  align="center"
                  key="productName"
                  prop="productName"
                  width="250" />
                <el-table-column
                  label="货品类型"
                  align="center"
                  key="productTypeName"
                  prop="type.productTypeName"
                  width="100" />
                <el-table-column
                  label="库存数量"
                  align="center"
                  key="inventoryQty"
                  prop="inventoryQty" /></el-table
            ></el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
import {
  salesAmountQuery,
  salesNotTakeEffectQuery,
  listOverstockProduct,
  listDangerProduct,
  listThreeOverstock,
  listSixOverstock,
  listTwelveOverstock,
} from "@/api/index";

// 销售总金额与毛利润
const dailySalesAmount = ref(0);
const lastMonthSalesAmount = ref(0);
const lastSixMonthsSalesAmount = ref(0);
const thisYearSalesAmount = ref(0);
const lastYearSalesAmount = ref(0);
const lastTwoYearsSalesAmount = ref(0);
const dailyGrossProfit = ref(0);
const lastMonthGrossProfit = ref(0);
const lastSixMonthsGrossProfit = ref(0);
const thisYearGrossProfit = ref(0);
const lastYearGrossProfit = ref(0);
const lastTwoYearsGrossProfit = ref(0);
// 待审核单据
const purchaseInReceipt = ref(0);
const purchaseOutReceipt = ref(0);
const salesOutReceipt = ref(0);
const salesRefundReceipt = ref(0);
const otherInReceipt = ref(0);
const otherOutReceipt = ref(0);
const otherTransferReceipt = ref(0);
const stocktakingReceipt = ref(0);
// 货品库存预警结果表
const overstockProductList = ref([]);
const dangerProductList = ref([]);
const threeOverstockList = ref([]);
const sixOverstockList = ref([]);
const twelveOverstockList = ref([]);
const loading = ref(false);
const total = ref(0);

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 1,
    orderFormType: undefined,
    orderFormStatus: undefined,
    receiptCategory: undefined,
    receiptType: undefined,
    receiptStatus: undefined,
    deliveryDate: undefined,
    invoiceDate: undefined,
  },
  rules: {},
});

const { queryParams, rules } = toRefs(data);

/** 重置表单 */
function Reset() {
  queryParams.value = {
    pageSize: 1,
    orderFormType: undefined,
    orderFormStatus: undefined,
    receiptCategory: undefined,
    receiptType: undefined,
    receiptStatus: undefined,
    deliveryDate: undefined,
    invoiceDate: undefined,
  };
}
// 销售金额与毛利润查询
function amountQuery() {
  salesAmountQuery().then((response) => {
    dailySalesAmount.value = response.dailySalesAmount;
    lastMonthSalesAmount.value = response.lastMonthSalesAmount;
    lastSixMonthsSalesAmount.value = response.lastSixMonthsSalesAmount;
    thisYearSalesAmount.value = response.thisYearSalesAmount;
    lastYearSalesAmount.value = response.lastYearSalesAmount;
    lastTwoYearsSalesAmount.value = response.lastTwoYearsSalesAmount;
    dailyGrossProfit.value = response.dailyGrossProfit;
    lastMonthGrossProfit.value = response.lastMonthGrossProfit;
    lastSixMonthsGrossProfit.value = response.lastSixMonthsGrossProfit;
    thisYearGrossProfit.value = response.thisYearGrossProfit;
    lastYearGrossProfit.value = response.lastYearGrossProfit;
    lastTwoYearsGrossProfit.value = response.lastTwoYearsGrossProfit;
  });
}
// 待审核单据查询
function notTakeEffectQuery() {
  salesNotTakeEffectQuery().then((response) => {
    purchaseInReceipt.value = response.purchaseInReceipt;
    purchaseOutReceipt.value = response.purchaseOutReceipt;
    salesOutReceipt.value = response.salesOutReceipt;
    salesRefundReceipt.value = response.salesRefundReceipt;
    otherInReceipt.value = response.otherInReceipt;
    otherOutReceipt.value = response.otherOutReceipt;
    otherTransferReceipt.value = response.otherTransferReceipt;
    stocktakingReceipt.value = response.stocktakingReceipt;
  });
}
/** 查询货品库存积压预警列表 */
function overstockProductQuery() {
  queryParams.value.pageSize = 50;
  loading.value = true;
  listOverstockProduct(queryParams.value).then((res) => {
    loading.value = false;
    overstockProductList.value = res.rows;
    total.value = res.total;
  });
}
/** 查询货品库存不足预警列表 */
function dangerProductQuery() {
  queryParams.value.pageSize = 50;
  loading.value = true;
  listDangerProduct(queryParams.value).then((res) => {
    loading.value = false;
    dangerProductList.value = res.rows;
    total.value = res.total;
  });
}
/** 积压3个月未出预警列表 */
function threeOverstockQuery() {
  queryParams.value.pageSize = 50;
  loading.value = true;
  listThreeOverstock(queryParams.value).then((res) => {
    loading.value = false;
    threeOverstockList.value = res.rows;
    total.value = res.total;
  });
}
/** 积压6个月未出预警列表 */
function sixOverstockQuery() {
  queryParams.value.pageSize = 50;
  loading.value = true;
  listSixOverstock(queryParams.value).then((res) => {
    loading.value = false;
    sixOverstockList.value = res.rows;
    total.value = res.total;
  });
}
/** 积压12个月未出预警列表 */
function twelveOverstockQuery() {
  queryParams.value.pageSize = 50;
  loading.value = true;
  listTwelveOverstock(queryParams.value).then((res) => {
    loading.value = false;
    twelveOverstockList.value = res.rows;
    total.value = res.total;
  });
}
/** 查询数据总条数列表 */
function getList() {
  amountQuery();
  notTakeEffectQuery();
  overstockProductQuery();
  dangerProductQuery();
  threeOverstockQuery();
  sixOverstockQuery();
  twelveOverstockQuery();
}

getList();
</script>

<style scoped>
.statistic-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  font-size: 12px;
  color: var(--el-text-color-regular);
  margin-top: 16px;
}

.statistic-footer .footer-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.statistic-footer .footer-item span:last-child {
  display: inline-flex;
  align-items: center;
  margin-left: 4px;
}

.green {
  color: var(--el-color-success);
}

.demo-tabs > .el-tabs__content {
  padding: 32px;
  color: #6b778c;
  font-size: 32px;
  font-weight: 600;
}

.el-tabs--right .el-tabs__content,
.el-tabs--left .el-tabs__content {
  height: 100%;
}
</style>
