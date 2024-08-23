<template>
  <div>
    <el-row :gutter="5">
      <el-col :span="12" v-hasPermi="['inventory:inventoryReceiptQuery:salesAmountQuery']">
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
      <el-col :span="12" v-hasPermi="['inventory:inventoryReceiptQuery:salesAmountQuery']">
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
    <el-row :gutter="5">
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>待审核</span>
            </div>
          </template>
          <el-row>
            <el-col :span="4" v-hasPermi="['purchase:purchaseOrderQuery:headShow']">
              <el-statistic
                title="采购订单"
                :value="purchaseOrderNotTakeEffect"
              />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span>当天新增</span>
                  <span class="green">
                    {{ purchaseOrderTodaySource }}
                    <el-icon>
                      <CaretTop />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="采购单据"
                :value="purchaseReceiptNotTakeEffect"
              />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span>当天新增</span>
                  <span class="green">
                    {{ purchaseReceiptTodaySource }}
                    <el-icon>
                      <CaretTop />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
            <el-col :span="4" v-hasPermi="['purchase:purchaseOrderQuery:headShow']">
              <el-statistic title="销售订单" :value="salesOrderNotTakeEffect" />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span>当天新增</span>
                  <span class="green">
                    {{ salesOrderTodaySource }}
                    <el-icon>
                      <CaretTop />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="销售单据"
                :value="salesReceiptNotTakeEffect"
              />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span>当天新增</span>
                  <span class="green">
                    {{ salesReceiptTodaySource }}
                    <el-icon>
                      <CaretTop />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="库存单据"
                :value="inventoryReceiptNotTakeEffect"
              />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span>当天新增</span>
                  <span class="green">
                    {{ inventoryReceiptTodaySource }}
                    <el-icon>
                      <CaretTop />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="调拨单据"
                :value="inventoryTransferNotTakeEffect"
              />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span>当天新增</span>
                  <span class="green">
                    {{ inventoryTransferTodaySource }}
                    <el-icon>
                      <CaretTop />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>已审核</span>
            </div>
          </template>
          <el-row>
            <el-col :span="4" v-hasPermi="['purchase:purchaseOrderQuery:headShow']">
              <el-statistic title="采购订单" :value="purchaseOrderTakeEffect" />
              <div class="statistic-footer">
                <div class="footer-item">
                  <span class="green">
                    实时统计
                    <el-icon>
                      <Histogram />
                    </el-icon>
                  </span>
                </div>
              </div>
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="采购单据"
                :value="purchaseReceiptTakeEffect"
              />
            </el-col>
            <el-col :span="4" v-hasPermi="['purchase:purchaseOrderQuery:headShow']">
              <el-statistic title="销售订单" :value="salesOrderTakeEffect" />
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic title="销售单据" :value="salesReceiptTakeEffect" />
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="库存单据"
                :value="inventoryReceiptTakeEffect"
              />
            </el-col>
            <el-col :span="4" v-hasPermi="['inventory:inventoryReceiptQuery:headShow']">
              <el-statistic
                title="调拨单据"
                :value="inventoryTransferTakeEffect"
              />
            </el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="5">
      <el-col :span="12" v-hasPermi="['baseDate:product:show']">
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
      <el-col :span="12" v-hasPermi="['baseDate:product:show']">
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
import { useTransition } from "@vueuse/core";
import { purchaseOrderHeadQuery } from "@/api/purchase/purchaseOrderQuery";
import {
  headQuery,
  salesAmountQuery,
} from "@/api/inventory/inventoryDocumentQuery";
import {
  listOverstockProduct,
  listDangerProduct,
  listThreeOverstock,
  listSixOverstock,
  listTwelveOverstock,
} from "@/api/basedate/product";

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
// 货品库存预警结果表
const overstockProductList = ref([]);
const dangerProductList = ref([]);
const threeOverstockList = ref([]);
const sixOverstockList = ref([]);
const twelveOverstockList = ref([]);
const loading = ref(false);
const total = ref(0);
// 采购订单待审核
const purchaseOrderNotTakeEffectSource = ref(0);
const purchaseOrderNotTakeEffect = useTransition(
  purchaseOrderNotTakeEffectSource,
  {
    duration: 500,
  }
);
// 采购订单待审核当日新增
const purchaseOrderTodaySource = ref(0);
// 采购单据待审核当日新增
const purchaseReceiptTodaySource = ref(0);
// 销售订单待审核当日新增
const salesOrderTodaySource = ref(0);
// 销售单据待审核当日新增
const salesReceiptTodaySource = ref(0);
// 库存单据待审核当日新增
const inventoryReceiptTodaySource = ref(0);
// 调拨单据待审核当日新增
const inventoryTransferTodaySource = ref(0);
// 采购订单已审核
const purchaseOrderTakeEffectSource = ref(0);
const purchaseOrderTakeEffect = useTransition(purchaseOrderTakeEffectSource, {
  duration: 500,
});
// 采购单据待审核
const purchaseReceiptNotTakeEffectSource = ref(0);
const purchaseReceiptNotTakeEffect = useTransition(
  purchaseReceiptNotTakeEffectSource,
  {
    duration: 500,
  }
);
// 采购单据已审核
const purchaseReceiptTakeEffectSource = ref(0);
const purchaseReceiptTakeEffect = useTransition(
  purchaseReceiptTakeEffectSource,
  {
    duration: 500,
  }
);
// 销售订单待审核
const salesOrderNotTakeEffectSource = ref(0);
const salesOrderNotTakeEffect = useTransition(salesOrderNotTakeEffectSource, {
  duration: 500,
});
// 销售订单已审核
const salesOrderTakeEffectSource = ref(0);
const salesOrderTakeEffect = useTransition(salesOrderTakeEffectSource, {
  duration: 500,
});
// 销售单据待审核
const salesReceiptNotTakeEffectSource = ref(0);
const salesReceiptNotTakeEffect = useTransition(
  salesReceiptNotTakeEffectSource,
  {
    duration: 500,
  }
);
// 销售单据已审核
const salesReceiptTakeEffectSource = ref(0);
const salesReceiptTakeEffect = useTransition(salesReceiptTakeEffectSource, {
  duration: 500,
});
// 库存单据待审核
const inventoryReceiptNotTakeEffectSource = ref(0);
const inventoryReceiptNotTakeEffect = useTransition(
  inventoryReceiptNotTakeEffectSource,
  {
    duration: 500,
  }
);
// 库存单据已审核
const inventoryReceiptTakeEffectSource = ref(0);
const inventoryReceiptTakeEffect = useTransition(
  inventoryReceiptTakeEffectSource,
  {
    duration: 500,
  }
);
// 调拨单据待审核
const inventoryTransferNotTakeEffectSource = ref(0);
const inventoryTransferNotTakeEffect = useTransition(
  inventoryTransferNotTakeEffectSource,
  {
    duration: 500,
  }
);
// 调拨单据已审核
const inventoryTransferTakeEffectSource = ref(0);
const inventoryTransferTakeEffect = useTransition(
  inventoryTransferTakeEffectSource,
  {
    duration: 500,
  }
);

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

function getNowTime() {
  var now = new Date();
  var year = now.getFullYear(); //得到年份
  var month = now.getMonth(); //得到月份
  var date = now.getDate(); //得到日期
  month = month + 1;
  month = month.toString().padStart(2, "0");
  date = date.toString().padStart(2, "0");
  var defaultDate = `${year}-${month}-${date}`;
  return defaultDate;
}
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
// 采购订单待审核查询
function purchaseOrderNotTakeEffectQuery() {
  queryParams.value.orderFormType = 1;
  queryParams.value.orderFormStatus = 1;
  purchaseOrderHeadQuery(queryParams.value).then((response) => {
    purchaseOrderNotTakeEffectSource.value = response.total;
  });
  Reset();
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
// 采购订单当天待审核查询
function purchaseOrderTodayQuery() {
  queryParams.value.orderFormType = 1;
  queryParams.value.orderFormStatus = 1;
  queryParams.value.deliveryDate = getNowTime();
  purchaseOrderHeadQuery(queryParams.value).then((response) => {
    purchaseOrderTodaySource.value = response.total;
  });
  Reset();
}
// 采购订单已审核查询
function purchaseOrderTakeEffectQuery() {
  queryParams.value.orderFormType = 1;
  queryParams.value.orderFormStatus = 2;
  purchaseOrderHeadQuery(queryParams.value).then((response) => {
    purchaseOrderTakeEffectSource.value = response.total;
  });
  Reset();
}
// 采购单据待审核查询
function purchaseReceiptNotTakeEffectQuery() {
  queryParams.value.receiptCategory = 1;
  queryParams.value.receiptStatus = 1;
  headQuery(queryParams.value).then((response) => {
    purchaseReceiptNotTakeEffectSource.value = response.total;
  });
  Reset();
}
// 采购单据当天待审核查询
function purchaseReceiptTodayQuery() {
  queryParams.value.receiptCategory = 1;
  queryParams.value.receiptStatus = 1;
  queryParams.value.invoiceDate = getNowTime();
  headQuery(queryParams.value).then((response) => {
    purchaseReceiptTodaySource.value = response.total;
  });
  Reset();
}
// 采购单据已审核查询
function purchaseReceiptTakeEffectQuery() {
  queryParams.value.receiptCategory = 1;
  queryParams.value.receiptStatus = 2;
  headQuery(queryParams.value).then((response) => {
    purchaseReceiptTakeEffectSource.value = response.total;
  });
  Reset();
}
// 销售订单待审核查询
function salesOrderNotTakeEffectQuery() {
  queryParams.value.orderFormType = 2;
  queryParams.value.orderFormStatus = 1;
  purchaseOrderHeadQuery(queryParams.value).then((response) => {
    salesOrderNotTakeEffectSource.value = response.total;
  });
  Reset();
}
// 销售订单当天待审核查询
function salesOrderTodayQuery() {
  queryParams.value.orderFormType = 2;
  queryParams.value.orderFormStatus = 1;
  queryParams.value.deliveryDate = getNowTime();
  purchaseOrderHeadQuery(queryParams.value).then((response) => {
    salesOrderTodaySource.value = response.total;
  });
  Reset();
}
// 销售订单已审核查询
function salesOrderTakeEffectQuery() {
  queryParams.value.orderFormType = 2;
  queryParams.value.orderFormStatus = 2;
  purchaseOrderHeadQuery(queryParams.value).then((response) => {
    salesOrderTakeEffectSource.value = response.total;
  });
  Reset();
}
// 销售单据待审核查询
function salesReceiptNotTakeEffectQuery() {
  queryParams.value.receiptCategory = 2;
  queryParams.value.receiptStatus = 1;
  headQuery(queryParams.value).then((response) => {
    salesReceiptNotTakeEffectSource.value = response.total;
  });
  Reset();
}
// 销售单据待审核查询
function salesReceiptTodayQuery() {
  queryParams.value.receiptCategory = 2;
  queryParams.value.receiptStatus = 1;
  queryParams.value.invoiceDate = getNowTime();
  headQuery(queryParams.value).then((response) => {
    salesReceiptTodaySource.value = response.total;
  });
  Reset();
}
// 销售单据已审核查询
function salesReceiptTakeEffectQuery() {
  queryParams.value.receiptCategory = 2;
  queryParams.value.receiptStatus = 2;
  headQuery(queryParams.value).then((response) => {
    salesReceiptTakeEffectSource.value = response.total;
  });
  Reset();
}
// 库存单据待审核查询
function inventoryReceiptNotTakeEffectQuery() {
  queryParams.value.receiptCategory = 3;
  queryParams.value.receiptStatus = 1;
  headQuery(queryParams.value).then((response) => {
    inventoryReceiptNotTakeEffectSource.value = response.total;
  });
  Reset();
}
// 库存单据当天待审核查询
function inventoryReceiptTodayQuery() {
  queryParams.value.receiptCategory = 3;
  queryParams.value.receiptStatus = 1;
  queryParams.value.invoiceDate = getNowTime();
  headQuery(queryParams.value).then((response) => {
    inventoryReceiptTodaySource.value = response.total;
  });
  Reset();
}
// 库存单据已审核查询
function inventoryReceiptTakeEffectQuery() {
  queryParams.value.receiptCategory = 3;
  queryParams.value.receiptStatus = 2;
  headQuery(queryParams.value).then((response) => {
    inventoryReceiptTakeEffectSource.value = response.total;
  });
  Reset();
}
// 调拨单据待审核查询
function inventoryTransferNotTakeEffectQuery() {
  queryParams.value.receiptCategory = 3;
  queryParams.value.receiptType = 7;
  queryParams.value.receiptStatus = 1;
  headQuery(queryParams.value).then((response) => {
    inventoryTransferNotTakeEffectSource.value = response.total;
  });
  Reset();
}
// 调拨单据当日待审核查询
function inventoryTransferTodayQuery() {
  queryParams.value.receiptCategory = 3;
  queryParams.value.receiptType = 7;
  queryParams.value.receiptStatus = 1;
  queryParams.value.invoiceDate = getNowTime();
  headQuery(queryParams.value).then((response) => {
    inventoryTransferTodaySource.value = response.total;
  });
  Reset();
}
// 调拨单据已审核查询
function inventoryTransferTakeEffectQuery() {
  queryParams.value.receiptCategory = 3;
  queryParams.value.receiptType = 7;
  queryParams.value.receiptStatus = 2;
  headQuery(queryParams.value).then((response) => {
    inventoryTransferTakeEffectSource.value = response.total;
  });
  Reset();
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
  purchaseOrderNotTakeEffectQuery();
  purchaseOrderTodayQuery();
  purchaseOrderTakeEffectQuery();
  purchaseReceiptNotTakeEffectQuery();
  purchaseReceiptTodayQuery();
  purchaseReceiptTakeEffectQuery();
  salesOrderNotTakeEffectQuery();
  salesOrderTodayQuery();
  salesOrderTakeEffectQuery();
  salesReceiptNotTakeEffectQuery();
  salesReceiptTodayQuery();
  salesReceiptTakeEffectQuery();
  inventoryReceiptNotTakeEffectQuery();
  inventoryReceiptTodayQuery();
  inventoryReceiptTakeEffectQuery();
  inventoryTransferNotTakeEffectQuery();
  inventoryTransferTodayQuery();
  inventoryTransferTakeEffectQuery();
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
