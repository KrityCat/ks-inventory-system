<template>
  <!-- 销售单据制作 -->
  <div class="app-container">
    <el-row :gutter="10">
      <el-col :span="24" :xs="24">
        <el-form
            ref="orderRef"
            :inline="true"
            :model="form"
            :rules="rules"
            label-width="100px"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
                v-model="form.systematicReceipt"
                class="form-item"
                disabled
            ></el-input>
          </el-form-item>
          <el-form-item label="单据类型" prop="receiptType">
            <el-radio-group v-model="form.receiptType" class="form-item">
              <el-radio-button
                  v-hasPermi="['sales:salesReceiptProcessing:Outbound']"
                  :value="3"
                  label="3"
                  @change="outbound"
              >销售出库
              </el-radio-button
              >
              <el-radio-button
                  v-hasPermi="['sales:salesReceiptProcessing:retreat']"
                  :value="4"
                  label="4"
                  @change="retreat"
              >销售退库
              </el-radio-button
              >
            </el-radio-group>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-radio-group v-model="form.receiptStatus" class="form-item">
              <el-radio-button v-if="pending" :value="1" label="1">待审核</el-radio-button>
              <el-radio-button v-if="audited" :value="2" label="2"
              >已审核
              </el-radio-button
              >
            </el-radio-group>
          </el-form-item>
          <el-form-item label="出货日期" prop="invoiceDate">
            <el-date-picker
                v-model="form.invoiceDate"
                format="YYYY/MM/DD"
                placeholder="请选择出货日期"
                type="date"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item v-if="retrieval" label="调出仓库" prop="retrievalIds">
            <el-select
                v-model="form.retrievalIds"
                :loading="loading"
                :remote-method="remoteWarehouse"
                class="form-item"
                clearable
                filterable
                placeholder="请输入仓库"
                remote
                remote-show-suffix
                @change="handleWarehouseChange"
            >
              <el-option
                  v-for="item in warehouseOptions"
                  :key="item.warehouseId"
                  :label="item.warehouseName"
                  :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item
              v-if="warehousing"
              label="调入仓库"
              prop="warehousingIds"
          >
            <el-select
                v-model="form.warehousingIds"
                :loading="loading"
                :remote-method="remoteWarehouse"
                class="form-item"
                clearable
                filterable
                placeholder="请输入仓库"
                remote
                remote-show-suffix
                @change="handleWarehouseChange"
            >
              <el-option
                  v-for="item in warehouseOptions"
                  :key="item.warehouseId"
                  :label="item.warehouseName"
                  :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item
              v-hasPermi="['sales:salesReceiptProcessing:selectUser']"
              label="经手人"
              prop="userIds"
          >
            <el-select
                v-model="form.userIds"
                class="form-item"
                clearable
                filterable
                placeholder="请选择"
            >
              <el-option
                  v-for="item in userOptions"
                  :key="item.userId"
                  :label="item.userName"
                  :value="item.userId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="客户" prop="customerIds">
            <el-select
                v-model="form.customerIds"
                :loading="loading"
                :remote-method="remoteCustomer"
                class="form-item"
                clearable
                filterable
                placeholder="请输入客户"
                remote
                remote-show-suffix
            >
              <el-option
                  v-for="item in customerOptions"
                  :key="item.customerId"
                  :label="item.customerName"
                  :value="item.customerId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="计划单号" prop="planReceipt">
            <el-input v-model="form.planReceipt" class="form-item" clearable/>
          </el-form-item>
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
                v-model="form.originalReceipt"
                class="form-item"
                clearable
            />
          </el-form-item>
          <el-form-item label="备注" prop="receiptNotes">
            <el-input
                v-model="form.receiptNotes"
                class="form-item"
                type="textarea"
            />
          </el-form-item>
          <el-form-item label="定金" prop="deposit">
            <el-input
                v-model="form.deposit"
                class="form-item"
                clearable
                oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
            />
          </el-form-item>
          <el-form-item label="总金额" prop="totalAmount">
            <el-input
                v-model="form.totalAmount"
                :formatter="
                (value) => `￥ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              "
                :parser="(value) => value.replace(/\￥\s?|(,*)/g, '')"
                class="form-item"
                disabled="disabled"
            />
          </el-form-item>
          <el-form-item label="总金额(大写)" prop="capitalizeTotalAmount">
            <el-input
                v-model="form.capitalizeTotalAmount"
                class="form-item"
                disabled="disabled"
            />
          </el-form-item>
          <el-form-item v-if="lockOutbound" label="销售订单" prop="isSalesOrder">
            <el-radio-group v-model="form.isSalesOrder" class="form-item">
              <el-radio-button :value="1" label="1">更新</el-radio-button>
              <el-radio-button :value="2" label="2">不更新</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item v-if="lockOutbound" label="是否售后安装" prop="afterSalesInstallation">
            <el-radio-group
                v-model="form.afterSalesInstallation"
                class="form-item"
            >
              <el-radio-button :value="0" label="0">是</el-radio-button>
              <el-radio-button :value="1" label="1">否</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <div v-if="finding">
            <el-divider/>
            <el-form-item
                :disabled="['sales:salesReceiptProcessing:takeEffect']"
                label="审核结果"
                prop="findingOfAudit"
            >
              <el-select
                  v-model="form.findingOfAudit"
                  class="form-item"
                  clearable
                  filterable
              >
                <el-option
                    v-for="dict in finding_of_audit"
                    :key="dict.value"
                    :label="dict.label"
                    :value="dict.value"
                />
              </el-select>
            </el-form-item>
            <el-form-item
                :disabled="['sales:salesReceiptProcessing:takeEffect']"
                label="审核意见"
                prop="reviewComments"
            >
              <el-input
                  v-model="form.reviewComments"
                  clearable
                  style="width: 530px"
              />
            </el-form-item>
          </div>
        </el-form>
        <div>
          <div>
            <el-row :gutter="10">
              <el-col :span="1.5">
                <div>货品明细</div>
              </el-col>
            </el-row>
          </div>
          <div>
            <el-table
                :data="form.details"
                :summary-method="getSummaries"
                border
                show-summary
            >
              <el-table-column
                  align="center"
                  label="序号"
                  type="index"
                  width="60"
              />
              <el-table-column v-if="lockOutbound" align="center" label="锁单货品" prop="lockedGoods" width="120">
                <template #default="scope">
                  <el-radio-group v-model="scope.row.lockedGoods">
                    <el-radio-button v-hasPermi="['sales:salesReceiptProcessing:lockedGoods']" :value="1" label="1">是
                    </el-radio-button>
                    <el-radio-button :value="0" label="0">否</el-radio-button>
                  </el-radio-group>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="货品编号"
                  prop="productCode"
                  width="180"
              >
                <template #default="scope">
                  <el-select
                      v-model="scope.row.productCode"
                      :loading="loading"
                      :remote-method="remoteProductCode"
                      filterable
                      placeholder="请输入货品编号"
                      remote
                      remote-show-suffix
                      @change="changeProduct(scope.$index, scope.row)"
                  >
                    <el-option
                        v-for="item in productOptions"
                        :key="item.productId"
                        :label="item.productCode"
                        :value="item.productId"
                    ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="货品名称"
                  prop="productName"
                  width="300"
              >
                <template #default="scope">
                  <el-select
                      v-model="scope.row.productName"
                      :loading="loading"
                      :remote-method="remoteProductName"
                      filterable
                      placeholder="请输入货品名称"
                      remote
                      remote-show-suffix
                      @change="changeProduct(scope.$index, scope.row)"
                  >
                    <el-option
                        v-for="item in productOptions"
                        :key="item.productId"
                        :label="item.productName"
                        :value="item.productId"
                    ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="类型"
                  prop="productTypeName"
              />
              <el-table-column
                  align="center"
                  label="规格"
                  prop="productSpecifications"
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.productSpecifications"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="单位" prop="measureUnit">
                <template #default="scope">
                  <el-input v-model="scope.row.measureUnit"></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="产地" prop="producer"/>
              <el-table-column
                  align="center"
                  label="库存数量"
                  prop="inventoryQty"
              >
                <template #default="scope">
                  <el-button
                      plain
                      round
                      type="primary"
                      @click="selectAllInventoryQty(scope.row.productId)"
                  >{{ scope.row.inventoryQty }}
                  </el-button
                  >
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="单据锁单数量"
                  prop="lockQty"
                  width="110"
              >
                <template #default="scope">
                  <el-button
                      plain
                      round
                      type="warning"
                      @click="selectLockQty(scope.row.productId)"
                  >{{ scope.row.lockQty }}
                  </el-button
                  >
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="数量"
                  prop="planQuantity"
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.planQuantity"
                      v-hasPermi="['sales:salesReceiptProcessing:planQuantity']"
                      oninput="this.value=this.value.replace(/[^\d]/g, '').replace(/^0+(\d)/, '$1').slice(0, 16).padEnd(1, '0')"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="单价"
                  prop="univalence"
                  width="150"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.univalence"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="折扣"
                  prop="discount"
                  width="80"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.discount"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="金额"
                  prop="money"
                  width="150"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.money"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="成本"
                  prop="cost"
                  width="180"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.cost"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="备注" width="180">
                <template #default="scope">
                  <el-input v-model="scope.row.remarks"></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" fixed="right" label="操作" width="90">
                <template #default="scope">
                  <el-button
                      plain
                      round
                      type="danger"
                      @click="form.details.splice(scope.$index, 1)"
                  >删除
                  </el-button
                  >
                </template>
              </el-table-column>
            </el-table>
          </div>
          <el-affix :offset="20" class="tc mt16 footer" position="bottom">
            <el-button
                v-hasPermi="['sales:salesReceiptProcessing:add']"
                color="#BB5500"
                icon="Plus"
                round
                @click="addOrder"
            >新增单据
            </el-button
            >
            <el-button
                v-hasPermi="['sales:salesReceiptProcessing:detail']"
                color="#00AAAA"
                icon="Plus"
                round
                @click="addItem"
            >添加明细
            </el-button
            >
            <el-button
                v-hasPermi="['baseDate:customer:add']"
                color="#626aef"
                icon="Upload"
                round
                @click="customerAdd"
            >新增客户
            </el-button
            >
            <el-button
                v-hasPermi="['baseDate:product:add']"
                icon="Upload"
                round
                type="warning"
                @click="handleAdd"
            >新增货品
            </el-button
            >
            <el-button
                v-hasPermi="['sales:salesReceiptProcessing:save']"
                :disabled="submitBtn"
                icon="position"
                round
                type="primary"
                @click="submitForm"
            >保存单据
            </el-button
            >
            <el-button
                v-hasPermi="['sales:salesReceiptProcessing:takeEffect']"
                :disabled="takeEffectBtn"
                icon="Check"
                round
                type="success"
                @click="auditingForm"
            >审核单据
            </el-button
            >
            <el-button
                v-hasPermi="['sales:salesReceiptProcessing:takeEffect']"
                :disabled="antiReviewBtn"
                icon="unlock"
                round
                type="danger"
                @click="antiReviewForm"
            >反审单据
            </el-button
            >
            <el-button
                v-hasPermi="['sales:salesReceiptProcessing:printOut']"
                :disabled="printBtn"
                color="#626aef"
                icon="Printer"
                round
                @click="printCommon"
            >打印单据
            </el-button
            >
            <el-tooltip
                class="box-item"
                content="删除单据，重新制作"
                placement="top"
            >
              <el-button
                  ref="ref22"
                  v-hasPermi="['sales:salesReceiptProcessing:delete']"
                  :disabled="printBtn"
                  icon="delete"
                  round
                  type="danger"
                  @click="deleteOrder"
              >删除单据
              </el-button
              >
            </el-tooltip>
            <el-tooltip
                class="box-item"
                content="取消制作，返回查询"
                placement="top"
            >
              <el-button icon="close" round type="info" @click="cancel"
              >取消制作
              </el-button
              >
            </el-tooltip>
          </el-affix>
        </div>
      </el-col>
    </el-row>
  </div>

  <!-- 添加客户配置对话框 -->
  <customer-dialog
      v-model:visible="openCustomer"
  />

  <!-- 添加货品配置对话框 -->
  <product-dialog
      v-model:visible="openProduct"
  />

  <!-- 查看货品库存对话框 -->
  <product-inventory-dialog
      v-model:visible="openProductInventory"
      :product-id="currentProductId"
  />

  <!-- 查看货品库存对话框 -->
  <product-inventory-dialog
      v-model:visible="openProductInventory"
      :product-id="currentProductId"
  />

  <!-- 查看单据锁单数量对话框 -->
  <lock-quantity-dialog
      v-model:visible="openLockQuantity"
      :product-id="currentProductId"
      :retrieval-id="retrievalId"
      :warehousing-id="warehousingId"
  />

  <!-- 查看打印模板对话框 -->
  <print-template-dialog
      v-model:visible="openPrintTemplate"
      :systematic-receipt="systematicReceipt"
  />
</template>

<script name="SalesDocumentProcessing" setup>
import {useRouter} from "vue-router";
import {getUserProfile} from "@/api/system/user";
import {delSalesReceipt, getSalesOrder, saveSalesReceipt,} from "@/api/sales/salesDocumentProcessing";
import {saveSalesOrder} from "@/api/sales/salesOrderProcessing";
import {saveAfterSales} from "@/api/aftersales/afterSalesOrderProcessing";
import {randomId} from "@/utils/RandomUtils";
import {ref} from "vue";
import {
  addProcessingBatch,
  deleteReceiptBatch,
  getColumns,
  getNowTime,
  getRemoteCustomer,
  getRemoteProduct,
  getRemoteWarehouse,
  SubmitVerification,
} from "@/utils/processingUtils";
import {customerList, userList, warehouseList,} from "@/api/common/CommonReceipt";
import productDialog from '@/components/CommonDialog/productDialog.vue';
import customerDialog from '@/components/CommonDialog/customerDialog.vue';
import productInventoryDialog from '@/components/CommonDialog/productInventoryDialog.vue';
import lockQuantityDialog from '@/components/CommonDialog/lockQuantityDialog.vue';
import printTemplateDialog from '@/components/CommonDialog/printTemplateDialog.vue';

const {proxy} = getCurrentInstance();
const {finding_of_audit} = proxy.useDict("finding_of_audit");

// 订单状态下拉框
const pending = ref(true);
const audited = ref(false);
const submitBtn = ref(false);
const takeEffectBtn = ref(false);
const antiReviewBtn = ref(true);
const finding = ref(false);
const printBtn = ref(false);
const retrieval = ref(true);
const warehousing = ref(false);
const loading = ref(false);
const lockOutbound = ref(true);
const router = useRouter();
// 窗口标题
const openCustomer = ref(false);
const openProduct = ref(false);
const openProductInventory = ref(false);
const openLockQuantity = ref(false);
const currentProductId = ref(null);
const warehousingId = ref(null);
const retrievalId = ref(null);
const openPrintTemplate = ref(false);
const systematicReceipt = ref(null);

const data = reactive({
  userOptions: undefined,
  customerOptions: undefined,
  warehouseOptions: undefined,
  productOptions: undefined,
  typeOptions: undefined,
  option: {
    warehousingId: undefined,
    retrievalId: undefined,
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
  // 表单参数
  form: {
    details: [],
    systematicReceipt: null,
    originalReceipt: null,
    receiptType: 3,
    receiptCategory: 2,
    receiptStatus: null,
    retrievalIds: null,
    warehousingIds: null,
    customerIds: null,
    userIds: null,
    invoiceDate: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    afterSalesInstallation: null,
    findingOfAudit: null,
    reviewComments: null,
    isSalesOrder: null,
    // 销售订单
    systematicOrderForm: null,
    originalOrderForm: null,
    orderFormType: 2,
    orderFormStatus: 2,
    deliveryDate: null,
    orderFormNotes: null,
    orderFormAmount: null,
    orderCapitalizeAmount: null,
    // 售后安装单
    serviceType: 1,
    // 打印ID
    printId: null,
  },
  // 表单校验
  rules: {
    receiptType: [
      {required: true, message: "单据类型不能不选", trigger: "blur"},
    ],
    warehousingIds: [
      {required: true, message: "调入仓库不能为空", trigger: "blur"},
    ],
    retrievalIds: [
      {required: true, message: "调出仓库不能为空", trigger: "blur"},
    ],
    userIds: [{required: true, message: "经手人不能为空", trigger: "blur"}],
    customerIds: [{required: true, message: "客户不能为空", trigger: "blur"}],
    invoiceDate: [
      {required: true, message: "交货日期不能为空", trigger: "blur"},
    ],
  },
});

const {
  userOptions,
  customerOptions,
  warehouseOptions,
  productOptions,
  option,
  form,
  rules,
} = toRefs(data);

function initialization() {
  const {systematicReceipt} = proxy.$route.query;
  if (systematicReceipt) {
    loadDetail(systematicReceipt);
  } else {
    reset();
    takeEffectBtn.value = true;
    antiReviewBtn.value = true;
    printBtn.value = true;
  }
}

async function getList() {
  option.value.pageSize = 500;
  userList(option.value).then((response) => {
    userOptions.value = response.rows;
  });
  getUserProfile().then((response) => {
    form.value.userIds = response.data.userId;
  });
  optionReset();
}

/** 新增按钮操作 */
function addOrder() {
  addProcessingBatch(router, proxy, 'SalesDocumentProcessing')
}

/** 销售出库 */
function outbound() {
  form.value.systematicReceipt = "XC-" + randomId();
  retrieval.value = true;
  warehousing.value = false;
  form.value.warehousingIds = null;
  lockOutbound.value = true;
}

function retreat() {
  form.value.systematicReceipt = "XT-" + randomId();
  retrieval.value = false;
  warehousing.value = true;
  form.value.retrievalIds = null;
  lockOutbound.value = false;
  form.value.details = [];
}

/** 统计金额和成本 */
function calculateDetails(row) {
  row.money = row.cost = Number(
      Math.abs(row.planQuantity) * row.univalence * row.discount
  ).toFixed(2);
}

/** 取消按钮 */
function cancel() {
  router.push({path: "/sales/salesDocumentQuery"});
}

/** 提交公共方法 */
function submitAuditingForm(isSubmit) {
  proxy.$refs["orderRef"].validate(async (valid) => {
    if (!valid) return;
    if (!await SubmitVerification(proxy, form)) return;
    const details = form.value.details.map((it) => {
      return {
        systematicOrderForm: form.value.systematicOrderForm,
        systematicReceipt: form.value.systematicReceipt,
        lockedGoods: it.lockedGoods,
        productId: it.productId,
        retrievalId: form.value.retrievalIds,
        warehousingId: form.value.warehousingIds,
        customerId: form.value.customerIds,
        productSpecifications: it.productSpecifications,
        measureUnit: it.measureUnit,
        planQuantity: it.planQuantity,
        univalence: it.univalence,
        discount: it.discount,
        money: it.money,
        cost: it.cost,
        remarks: it.remarks,
      };
    });
    if (isSubmit === 1) {
      proxy.$modal.msgSuccess("销售单据保存成功");
      cancel();
    } else if (isSubmit === 2) {
      form.value.receiptStatus = 2;
      proxy.$modal.msgSuccess("销售出库单审核成功");
      cancel();
    }
    const reqs = {...form.value, details};
    await saveSalesReceipt(reqs);
    if (form.value.isSalesOrder === 1) {
      await saveSalesOrder(reqs);
    }
    if (form.value.afterSalesInstallation === 0) {
      await saveAfterSales(reqs);
      proxy.$modal.msgSuccess("售后安装单新建成功");
    }
    cancel();
  });
}

/** 提交按钮 */
function submitForm() {
  submitAuditingForm(1);
}

/** 审核按钮 */
function auditingForm() {
  submitAuditingForm(2);
}

/** 反审按钮 */
function antiReviewForm() {
  getSalesOrder(form.value.systematicReceipt).then(async (response) => {
    const details = response.data.details;
    form.value = {
      ...response.data,
      details,
    }
    form.value.receiptStatus = 1;
    const reqs = {...form.value, details};
    await saveSalesReceipt(reqs);
    proxy.$modal.msgSuccess("单据反审成功");
    cancel();
  });
}

function loadDetail(systematicReceipt) {
  getSalesOrder(systematicReceipt).then((response) => {
    warehouseList(option.value).then((response) => {
      warehouseOptions.value = response.rows;
    });
    option.value.customerId = response.data.customerIds;
    customerList(option.value).then((response) => {
      customerOptions.value = response.rows;
    });
    optionReset();
    if (response.data.receiptStatus === 2) {
      pending.value = false;
      audited.value = true;
      submitBtn.value = true;
      takeEffectBtn.value = true;
      antiReviewBtn.value = false;
    }
    printBtn.value = false;
    finding.value = true;
    const details = response.data.details;
    const product = response.data.product;
    const map = {};
    (product || []).forEach((it) => {
      map[it.productId] = it;
    });
    form.value = {
      ...response.data,
      // 销售订单
      systematicOrderForm: response.data.systematicReceipt,
      originalOrderForm: response.data.originalReceipt,
      orderFormType: 2,
      orderFormStatus: 2,
      deliveryDate: response.data.invoiceDate,
      orderFormNotes: response.data.receiptNotes,
      orderFormAmount: response.data.totalAmount,
      orderCapitalizeAmount: response.data.capitalizeTotalAmount,
      // 售后安装单
      serviceType: 1,
      details,
    };
    form.value.warehousingIds = Number(response.data.warehousingIds);
    form.value.retrievalIds = Number(response.data.retrievalIds);
    form.value.userIds = Number(response.data.userIds);
    form.value.customerIds = Number(response.data.customerIds);
    form.value.isSalesOrder = 1;
  });
}

//自定义合计行
function getSummaries(param) {
  const {columns, data} = param;
  const sums = new Array(columns.length).fill("");
  if (form.value.receiptType === 3) {
    getColumns(columns, data, form, sums, [1, 2, 3, 4, 5, 6, 7, 13], [14, 15]);
    return sums;
  } else if (form.value.receiptType === 4) {
    getColumns(columns, data, form, sums, [1, 2, 3, 4, 5, 6, 10], [11, 12]);
    return sums;
  }
}

// 表单重置
function reset() {
  form.value = {
    systematicReceipt: null,
    originalReceipt: null,
    receiptType: null,
    receiptCategory: 2,
    receiptStatus: 1,
    invoiceDate: getNowTime(),
    retrievalIds: null,
    warehousingIds: null,
    customerIds: null,
    userIds: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    isSalesOrder: 2,
    afterSalesInstallation: 1,
    findingOfAudit: null,
    reviewComments: null,
    // 销售订单
    systematicOrderForm: null,
    originalOrderForm: null,
    orderFormType: 2,
    orderFormStatus: 2,
    deliveryDate: null,
    orderFormNotes: null,
    orderFormAmount: null,
    orderCapitalizeAmount: null,
    // 售后安装单
    serviceType: 1,
    printId: null,
    details: [],
  };
  proxy.resetForm("orderRef");
}

// 添加货品
function addItem() {
  proxy.$refs["orderRef"].validate((valid) => {
    if (!valid) {
      proxy.$modal.msgError("请先选择单据头信息");
      return;
    }
    form.value.details.push({});
  });
}

// 选择货品
function changeProduct(index, row) {
  form.value.details[index] = {
    lockedGoods: null,
    productId: null,
    productCode: null,
    productName: null,
    productTypeName: null,
    productSpecifications: null,
    measureUnit: null,
    producer: null,
    inventoryQty: null,
    lockQty: null,
    retrievalId: null,
    warehousingId: null,
  };
  let lists = [];
  productOptions.value.forEach((item) => {
    const targetId = item.productId;
    if (row.productCode === targetId || row.productName === targetId) {
      lists = item;
    }
  });
  form.value.details[index] = {
    systematicOrderForm: form.value.systematicOrderForm,
    systematicReceipt: form.value.systematicReceipt,
    lockedGoods: lists.lockedGoods,
    productId: lists.productId,
    productCode: lists.productCode,
    productName: lists.productName,
    productTypeName: lists.productTypeName,
    productSpecifications: lists.productSpecifications,
    measureUnit: lists.measureUnit,
    producer: lists.producer,
    inventoryQty: lists.inventoryQty,
    lockQty: lists.lockQty,
    retrievalId: form.value.retrievalIds,
    warehousingId: form.value.warehousingIds,
    customerId: form.value.customerIds,
    planQuantity: 0,
    univalence: lists.univalence,
    discount: lists.discount,
    money: 0,
    cost: 0,
    remarks: null,
  };
  form.value.details = [...form.value.details];
}

/** 删除按钮操作 */
function deleteOrder() {
  deleteReceiptBatch(router, proxy, form, getSalesOrder, delSalesReceipt, 'SalesDocumentProcessing');
}

/** 新增客户按钮操作 */
function customerAdd() {
  openCustomer.value = true;
}

/** 新增货品按钮操作 */
function handleAdd() {
  openProduct.value = true;
}

/** 重置下拉框表单 */
function optionReset() {
  option.value = {
    warehousingId: undefined,
    retrievalId: undefined,
    warehouseId: undefined,
    warehouseName: undefined,
    supplierId: undefined,
    supplierName: undefined,
    customerId: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  };
}

// 查询仓库名称
function remoteWarehouse(query) {
  optionReset();
  getRemoteWarehouse(query, loading, option, warehouseOptions);
}

// 查询客户名称
function remoteCustomer(query) {
  optionReset();
  getRemoteCustomer(query, loading, option, customerOptions);
}

// 查询货品编号
function remoteProductCode(query) {
  optionReset();
  option.value.warehousingId = form.value.warehousingIds;
  option.value.retrievalId = form.value.retrievalIds;
  getRemoteProduct(query, "productCode", loading, option, productOptions);
}

// 查询货品名称
function remoteProductName(query) {
  optionReset();
  option.value.warehousingId = form.value.warehousingIds;
  option.value.retrievalId = form.value.retrievalIds;
  getRemoteProduct(query, "productName", loading, option, productOptions);
}

// 打印按钮
function printCommon() {
  systematicReceipt.value = form.value.systematicReceipt;
  openPrintTemplate.value = true;
}

function handleWarehouseChange() {
  form.value.details = [];
}

function selectAllInventoryQty(productId) {
  if (!productId || typeof productId !== 'string') {
    proxy.$modal.msgError('请选择货品');
    return;
  }

  currentProductId.value = productId;
  openProductInventory.value = true;
}

function selectLockQty(productId) {
  if (!productId || typeof productId !== 'string') {
    proxy.$modal.msgError('请选择货品');
    return;
  }

  currentProductId.value = productId;
  warehousingId.value = form.value.warehousingIds;
  retrievalId.value = form.value.retrievalIds;
  openLockQuantity.value = true;
}

initialization();
getList();
</script>

<style scoped>
.form-item {
  width: 200px;
}

.long-form-item {
  width: 200px;
}

.footer {
  text-align: center;
}
</style>
