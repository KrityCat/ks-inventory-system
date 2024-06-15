<template>
  <!-- 销售退库单制作 -->
  <div class="app-container">
    <el-row :gutter="10">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          label-width="100px"
          :model="form"
          ref="form"
          :rules="rules"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
              class="form-item"
              v-model="form.systematicReceipt"
              placeholder="系统单号"
              disabled="disabled"
            ></el-input>
          </el-form-item>
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
              v-model="form.originalReceipt"
              class="form-item"
              clearable
            />
          </el-form-item>
          <el-form-item label="单据类型" prop="receiptType">
            <el-radio-group class="form-item" v-model="form.receiptType">
              <el-radio-button label="3" disabled>销售出库</el-radio-button>
              <el-radio-button label="4">销售退库</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-select
              class="form-item"
              v-model="form.receiptStatus"
              :disabled="takeEffect"
            >
              <el-option label="拟制" :value="1">拟制</el-option>
              <el-option
                label="生效"
                :value="2"
                :disabled="['system:sales:takeEffectSalesRetreat']"
                >生效</el-option
              >
            </el-select>
          </el-form-item>
          <el-form-item label="退货日期" prop="invoiceDate">
            <el-date-picker
              v-model="form.invoiceDate"
              type="date"
              placeholder="请选择退货日期"
              format="YYYY/MM/DD"
              value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="仓库" prop="warehousingIds">
            <el-select
              class="form-item"
              v-model="form.warehousingIds"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in warehouseOptions"
                :key="item.warehouseId"
                :label="item.warehouseName"
                :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="经手人" prop="userIds">
            <el-select
              class="form-item"
              v-model="form.userIds"
              placeholder="请选择"
              filterable
              clearable
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
              class="form-item"
              v-model="form.customerIds"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in customerOptions"
                :key="item.customerId"
                :label="item.customerName"
                :value="item.customerId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="订单号" prop="planReceipt">
            <el-input v-model="form.planReceipt" class="form-item" clearable />
          </el-form-item>
          <el-form-item label="备注" prop="receiptNotes">
            <el-input
              v-model="form.receiptNotes"
              class="form-item"
              type="textarea"
            />
          </el-form-item>
          <el-form-item label="定金" prop="deposit">
            <el-input v-model="form.deposit" class="form-item" clearable />
          </el-form-item>
          <el-form-item label="总金额" prop="totalAmount">
            <el-input
              v-model="form.totalAmount"
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
        </el-form>
        <div>
          <div>
            <el-row :gutter="10">
              <el-col :span="22">
                <div>货品明细</div>
              </el-col>
              <div>
                <el-button type="primary" plain="plain" @click="showAddItem"
                  >添加货品</el-button
                >
              </div>
            </el-row>
          </div>
          <div>
            <el-table
              :data="form.details"
              show-summary
              :summary-method="getSummaries"
            >
              <el-table-column
                label="货品编号"
                align="center"
                prop="prod.productCode"
              />
              <el-table-column
                label="货品名称"
                align="center"
                prop="prod.productName"
              />
              <el-table-column
                label="类型"
                align="center"
                prop="prod.type.productTypeName"
              />
              <el-table-column
                label="规格"
                align="center"
                prop="prod.productSpecifications"
              />
              <el-table-column
                label="单位"
                align="center"
                prop="prod.measureUnit"
              />
              <el-table-column
                label="产地"
                align="center"
                prop="prod.producer"
              />
              <el-table-column
                label="数量"
                align="center"
                prop="planQuantity"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.planQuantity"
                    :precision="0"
                    @change="calculateDetails(scope.row)"
                    :min="1"
                    :max="2147483647"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column
                label="单价"
                align="center"
                prop="univalence"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.univalence"
                    :precision="2"
                    @change="calculateDetails(scope.row)"
                    :min="0"
                    :max="2147483647"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column label="折扣" align="center" width="180">
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.discount"
                    :precision="2"
                    :step="0.01"
                    :min="0.0"
                    @change="calculateDetails(scope.row)"
                  >
                  </el-input-number>
                </template>
              </el-table-column>
              <el-table-column
                label="金额"
                align="center"
                prop="money"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.money"
                    :precision="2"
                    :min="0"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column
                label="成本"
                align="center"
                prop="cost"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.cost"
                    :precision="2"
                    :min="0"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column label="备注" align="center" width="180">
                <template #default="scope">
                  <el-input v-model="scope.row.remarks"></el-input>
                </template>
              </el-table-column>
              <el-table-column fixed="right" label="操作" align="center">
                <template #default="scope">
                  <el-button
                    type="danger"
                    plain
                    round
                    @click="form.details.splice(scope.$index, 1)"
                    >删除</el-button
                  >
                </template>
              </el-table-column>
            </el-table>
          </div>
          <div class="tc mt16 footer">
            <el-button @click="cancel">取消</el-button>
            <el-button
              @click="submitForm"
              type="primary"
              v-hasPermi="['system:sales:saveSalesRetreat']"
              >保存</el-button
            >
          </div>
        </div>
      </el-col>
    </el-row>
    <!-- 添加货品配置对话框 -->
    <el-dialog
      v-model="open"
      :title="modalObj.title"
      :width="modalObj.width"
      @close="modalObj.cancel"
    >
      <template v-if="modalObj.component === 'add-item'">
        <ItemSelect ref="item-select" :data="this.form.details"></ItemSelect>
      </template>
      <span>
        <el-button v-if="modalObj.cancel" @click="modalObj.cancel"
          >取消</el-button
        >
        <el-button v-if="modalObj.ok" type="primary" @click="modalObj.ok"
          >确认</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { listUser } from "@/api/system/user";
import { listCustomer } from "@/api/basedate/customer";
import { listWarehouse } from "@/api/basedate/warehouse";
import { getSalesOrder, saveSalesReceipt } from "@/api/sales/salesRetreat";
import { randomId } from "@/utils/RandomUtils";
import RMBConverter from "@/utils/RMBConverter";
import { ElNotification } from "element-plus";

export default {
  name: "salesRetreat",
  data() {
    return {
      userOptions: undefined,
      customerOptions: undefined,
      warehouseOptions: undefined,
      open: false,
      ids: [],
      // 单据状态下拉框
      takeEffect: true,
      // 表单参数
      form: {
        details: [],
        originalReceipt: null,
        payableAmount: 0.0,
        receiptCategory: 2,
        receiptType: 4,
        receiptStatus: null,
        warehousingIds: null,
        customerIds: null,
        userIds: null,
        invoiceDate: null,
        planReceipt: null,
        receiptNotes: null,
        deposit: null,
        totalAmount: null,
        capitalizeTotalAmount: null,
      },
      // 表单校验
      rules: {
        originalReceipt: [
          { required: true, message: "原始单号不能为空", trigger: "blur" },
        ],
        warehousingIds: [
          { required: true, message: "仓库不能为空", trigger: "blur" },
        ],
        userIds: [
          { required: true, message: "经手人不能为空", trigger: "blur" },
        ],
        customerIds: [
          { required: true, message: "客户不能为空", trigger: "blur" },
        ],
        invoiceDate: [
          { required: true, message: "退货日期不能为空", trigger: "blur" },
        ],
      },
      modalObj: {
        open: false,
        title: "",
        width: "50%",
        component: null,
        model: {},
        ok: () => {},
        cancel: () => {},
      },
    };
  },
  watch: {},
  created() {
    const { systematicReceipt } = this.$route.query;
    if (systematicReceipt) {
      this.loadDetail(systematicReceipt);
    } else {
      this.reset();
      this.form.receiptStatus = 1;
    }
    this.getList();
  },
  methods: {
    getList() {
      listWarehouse().then((response) => {
        this.warehouseOptions = response.rows;
      });
      listCustomer().then((response) => {
        this.customerOptions = response.rows;
      });
      listUser().then((response) => {
        this.userOptions = response.rows;
      });
    },
    /** 统计金额和成本 */
    calculateDetails(row) {
      row.money = row.cost =
        Math.abs(row.planQuantity) * row.univalence * row.discount;
    },
    cancel() {
      this.$tab.closeOpenPage({ path: "/index" });
      return ElNotification({
        title: "成功",
        message: "已返回主页",
        type: "success",
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (this.form.details.length === 0) {
          return ElNotification({
            title: "错误",
            message: "货品明细不能为空",
            type: "error",
          });
        } else if (!valid) {
          return;
        }
        const details = this.form.details.map((it) => {
          console.log(it.place);
          return {
            systematicReceipt: this.form.systematicReceipt,
            productId: it.prod.productId,
            warehousingId: this.form.warehousingIds,
            warehouseId: this.form.warehousingIds,
            customerId: this.form.customerIds,
            money: it.money,
            planQuantity: it.planQuantity,
            univalence: it.univalence,
            discount: it.discount,
            money: it.money,
            cost: it.cost,
            remarks: it.remarks,
          };
        });
        const req = { ...this.form, details };
        saveSalesReceipt(req).then((response) => {
          this.$modal.msgSuccess("销售退库单保存成功");
          this.cancel();
        });
      });
    },
    loadDetail(systematicReceipt) {
      getSalesOrder(systematicReceipt).then((response) => {
        const details = response.data.detail;
        const product = response.data.product;
        const receiptStatus = response.data.receiptStatus;
        const map = {};
        (product || []).forEach((it) => {
          map[it.productId] = it;
        });
        details && details.forEach((it) => (it.prod = map[it.productId]));
        this.form = {
          ...response.data,
          details,
        };
        this.form.warehousingIds = Number(response.data.warehousingIds);
        this.form.userIds = Number(response.data.userIds);
        this.form.customerIds = Number(response.data.customerIds);

        if (receiptStatus === 1) {
          this.takeEffect = false;
        } else {
          this.takeEffect = true;
        }
      });
    },
    //自定义合计行
    getSummaries(param) {
      const { columns, data } = param;
      const sums = [];
      columns.forEach((column, index) => {
        if (index === 0) {
          sums[index] = "合计";
          return;
        }

        if (column.property !== undefined) {
          //加了prop属性的el-table-column 才能找到column.property
          const values = data.map((item) => Number(item[column.property]));
          if (!values.every((value) => isNaN(value))) {
            sums[index] = values.reduce((prev, curr) => {
              const value = Number(curr);
              if (!isNaN(value)) {
                return prev + curr; // 多行相加
              } else {
                return prev;
              }
            }, 0);
          } else {
            sums[index] = "";
          }
          if (index === 9) {
            sums[index] = Number(sums[index]).toFixed(2); // 指定第九个 prop 保留2位小数
            this.form.totalAmount = sums[index];
            this.form.capitalizeTotalAmount = RMBConverter.numberToChinese(
              sums[index]
            );
          }
          if (index === 10) {
            sums[index] = Number(sums[index]).toFixed(2); // 指定第十个 prop 保留2位小数
          }
        }
      });
      return sums;
    },
    // 表单重置
    reset() {
      this.form = {
        systematicReceipt: "XT-" + randomId(),
        originalReceipt: null,
        receiptCategory: 2,
        receiptType: 4,
        receiptStatus: null,
        invoiceDate: null,
        planReceipt: null,
        receiptNotes: null,
        deposit: null,
        totalAmount: null,
        capitalizeTotalAmount: null,
        details: [],
      };
      this.resetForm("form");
    },
    confirmSelectItem() {
      const value = this.$refs["item-select"].getRightList();
      this.form.details = value.map((it) => {
        return {
          productId: it.productId,
          prod: it,
          planQuantity: 1,
          univalence: 0,
          discount: 0,
          money: 0,
          place: [],
        };
      });
      this.closeModal();
    },
    closeModal() {
      this.open = false;
    },
    showAddItem() {
      this.open = true;
      try {
        this.$refs["item-select"].initDetailsList(this.form.details);
      } catch (err) {}
      const ok = () => this.confirmSelectItem();
      const cancel = () => this.closeModal();
      this.modalObj = {
        title: "添加货品",
        width: "90%",
        component: "add-item",
        model: {},
        ok,
        cancel,
      };
    },
  },
};
</script>

<style scoped>
.form-item {
  width: 220px;
}
.footer {
  text-align: center;
}
</style>
