<template>
  <!-- 库存盘点单制作 -->
  <div class="app-container">
    <el-row :gutter="10">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          label-width="80px"
          :model="form"
          ref="form"
          :rules="rules"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
              class="form-item"
              v-model="form.systematicReceipt"
              disabled="disabled"
            ></el-input>
          </el-form-item>
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
              v-model="form.originalReceipt"
              class="form-item"
              placeholder="请输入"
              clearable
            />
          </el-form-item>
          <el-form-item label="单据类型" prop="receiptType">
            <el-radio-group class="form-item" v-model="form.receiptType">
              <el-radio-button label="8">库存盘点</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-radio-group class="form-item" v-model="form.receiptStatus">
              <el-radio-button label="1" disabled>拟制</el-radio-button>
              <el-radio-button label="2">生效</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="发生日期" prop="invoiceDate">
            <el-date-picker
              v-model="form.invoiceDate"
              type="date"
              placeholder="请选择"
              format="YYYY/MM/DD"
              value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="盘点仓库" prop="warehousingIds">
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
          <el-form-item label="计划订单" prop="planReceipt">
            <el-input v-model="form.planReceipt" class="form-item" clearable />
          </el-form-item>
          <el-form-item label="备注" prop="receiptNotes">
            <el-input
              v-model="form.receiptNotes"
              class="form-item"
              type="textarea"
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
            <el-table :data="form.details" show-summary>
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
                label="当前库存量"
                align="center"
                prop="currentInventory"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.currentInventory"
                    @change="calculateDetails(scope.row)"
                    :precision="0"
                    :min="0"
                    :max="2147483647"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column
                label="实际库存量"
                align="center"
                prop="actualInventory"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.actualInventory"
                    @change="calculateDetails(scope.row)"
                    :precision="0"
                    :min="0"
                    :max="2147483647"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column
                label="数量"
                align="center"
                prop="planQuantity"
                width="180"
              >
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.planQuantity"
                    @change="calculateDetails(scope.row)"
                    :precision="0"
                    :min="-2147483647"
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
                    @change="calculateDetails(scope.row)"
                    :precision="2"
                    :min="0"
                    :max="2147483647"
                  ></el-input-number>
                </template>
              </el-table-column>
              <el-table-column label="折扣" align="center" width="180">
                <template #default="scope">
                  <el-input-number
                    v-model="scope.row.discount"
                    @change="calculateDetails(scope.row)"
                    :precision="2"
                    :step="0.01"
                    :min="0.0"
                  ></el-input-number>
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
                    label="请输入金额"
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
                    label="请输入成本"
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
              v-hasPermi="['system:inventory:saveInventoryCounting']"
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
import { listSupplier } from "@/api/basedate/supplier";
import { listCustomer } from "@/api/basedate/customer";
import { listWarehouse } from "@/api/basedate/warehouse";
import {
  getHeadReceipt,
  saveInventoryCounting,
} from "@/api/inventory/inventoryCounting";
import { randomId } from "@/utils/RandomUtils";
import { ElNotification } from "element-plus";

export default {
  name: "InventoryCounting",
  data() {
    return {
      userOptions: undefined,
      supplierOptions: undefined,
      customerOptions: undefined,
      warehouseOptions: undefined,
      open: false,
      ids: [],
      // 单据状态下拉框
      takeEffect: true,
      // 表单参数
      form: {
        details: [],
        payableAmount: 0.0,
        receiptType: 8,
        receiptCategory: 3,
        receiptStatus: null,
        warehousingIds: null,
        supplierIds: null,
        customerIds: null,
        userIds: null,
        invoiceDate: null,
        planReceipt: null,
        receiptNotes: null,
      },
      // 表单校验
      rules: {
        originalReceipt: [
          { required: true, message: "原始单号不能为空", trigger: "blur" },
        ],
        warehousingIds: [
          { required: true, message: "盘点仓库不能为空", trigger: "blur" },
        ],
        userIds: [
          { required: true, message: "经手人不能为空", trigger: "blur" },
        ],
        invoiceDate: [
          { required: true, message: "发生日期不能为空", trigger: "blur" },
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
      this.form.receiptStatus = 2;
    }
    this.getList();
  },
  methods: {
    getList() {
      listWarehouse().then((response) => {
        this.warehouseOptions = response.rows;
      });
      listSupplier().then((response) => {
        this.supplierOptions = response.rows;
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
      if (
        row.actualInventory == 0 &&
        row.currentInventory == 0 &&
        row.planQuantity != 0
      ) {
        row.money = row.cost =
          Math.abs(row.planQuantity) * row.univalence * row.discount;
      } else {
        row.planQuantity = row.actualInventory - row.currentInventory;
        row.money = row.cost =
          Math.abs(row.planQuantity) * row.univalence * row.discount;
      }
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
            supplierId: this.form.supplierIds,
            customerId: this.form.customerIds,
            currentInventory: it.currentInventory,
            actualInventory: it.actualInventory,
            planQuantity: it.planQuantity,
            univalence: it.univalence,
            discount: it.discount,
            money: it.money,
            cost: it.cost,
            remarks: it.remarks,
          };
        });
        const req = { ...this.form, details };
        saveInventoryCounting(req).then((response) => {
          ElNotification({
            title: "成功",
            message: "库存盘点单保存成功",
            type: "success",
          });
          this.cancel();
        });
      });
    },
    loadDetail(systematicReceipt) {
      getHeadReceipt(systematicReceipt).then((response) => {
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
        if (Number(response.data.supplierIds) === 0) {
          this.form.supplierIds = null;
        } else {
          this.form.supplierIds = Number(response.data.supplierIds);
        }
        if (Number(response.data.customerIds) === 0) {
          this.form.customerIds = null;
        } else {
          this.form.customerIds = Number(response.data.customerIds);
        }

        if (receiptStatus === 1) {
          this.takeEffect = false;
        } else {
          this.takeEffect = true;
        }
      });
    },
    // 表单重置
    reset() {
      this.form = {
        systematicReceipt: "PD-" + randomId(),
        receiptType: 8,
        receiptCategory: 3,
        receiptStatus: null,
        invoiceDate: null,
        warehousingIds: null,
        userIds: null,
        customerIds: null,
        supplierIds: null,
        customerIds: null,
        planReceipt: null,
        receiptNotes: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
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
          currentInventory: 0,
          actualInventory: 0,
          planQuantity: 0,
          univalence: 0,
          discount: 0,
          money: 0,
          cost: 0,
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
