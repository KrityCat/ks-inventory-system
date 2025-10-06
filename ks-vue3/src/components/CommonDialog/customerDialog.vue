<!-- 添加客户配置对话框 -->
<template>
  <el-dialog
      :title="titleCustome"
      :model-value="visible"
      @update:modelValue="$emit('update:visible', $event)"
      width="700px"
      append-to-body
  >
    <el-form
        :model="customerForm"
        :rules="rules"
        ref="customerRef"
        label-width="80px"
    >
      <el-row>
        <el-col :span="12">
          <el-form-item label="客户编号" prop="customerCode">
            <el-input
                v-model="customerForm.customerCode"
                placeholder="请输入客户编号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="客户名称" prop="customerName">
            <el-input
                v-model="customerForm.customerName"
                placeholder="请输入客户名称"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="业务员" prop="customerSalesPerson">
            <el-input
                v-model="customerForm.customerSalesPerson"
                placeholder="请输入业务员"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系人" prop="customerContacts">
            <el-input
                v-model="customerForm.customerContacts"
                placeholder="请输入联系人"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="联系电话" prop="customerContactNumber">
            <el-input
                v-model="customerForm.customerContactNumber"
                placeholder="请输入联系电话"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="邮编" prop="customerPostalCode">
            <el-input
                v-model="customerForm.customerPostalCode"
                placeholder="请输入邮编"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="期初欠款" prop="customerOpeningDebt">
            <el-input
                v-model="customerForm.customerOpeningDebt"
                placeholder="请输入期初欠款"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="开户银行" prop="customerOpeningBank">
            <el-input
                v-model="customerForm.customerOpeningBank"
                placeholder="请输入开户银行"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="银行账号" prop="customerAccountNumber">
            <el-input
                v-model="customerForm.customerAccountNumber"
                placeholder="请输入银行账号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="纳税号" prop="customerTaxId">
            <el-input
                v-model="customerForm.customerTaxId"
                placeholder="请输入纳税号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="公司主页" prop="customerCompanyHomepage">
            <el-input
                v-model="customerForm.customerCompanyHomepage"
                placeholder="请输入公司主页"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="电子邮箱" prop="customerEmail">
            <el-input
                v-model="customerForm.customerEmail"
                placeholder="请输入电子邮箱"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="公司法人" prop="customerLegalPerson">
            <el-input
                v-model="customerForm.customerLegalPerson"
                placeholder="请输入公司法人"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status">
            <el-select
                v-model="customerForm.status"
                placeholder="请选择"
                clearable
            >
              <el-option
                  v-for="dict in sys_normal_disable"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
              />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <el-form-item label="单位地址" prop="customerWorkAddress">
            <el-input
                v-model="customerForm.customerWorkAddress"
                placeholder="请输入单位地址"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <el-form-item label="备注">
            <el-input
                v-model="customerForm.remarks"
                type="textarea"
                placeholder="请输入备注"
            />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button type="primary" @click="submitCustomerForm">确 定</el-button>
        <el-button @click="cancelCustomerForm">取 消</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { listCustomer, addCustomer } from "@/api/basedate/customer";
import {defineEmits, defineProps, ref} from "vue";

const props = defineProps({ visible: Boolean })
const emit = defineEmits(['update:visible', 'success'])

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

const titleCustome = ref("新增客户");

const data = reactive({
  typeOptions: undefined,
  customerForm: {
    customerCode: undefined,
    customerName: undefined,
    customerSalesPerson: undefined,
    customerContacts: undefined,
    customerContactNumber: undefined,
    customerWorkAddress: undefined,
    customerPostalCode: undefined,
    customerOpeningDebt: undefined,
    customerOpeningBank: undefined,
    customerAccountNumber: undefined,
    customerTaxId: undefined,
    customerCompanyHomepage: undefined,
    customerEmail: undefined,
    customerLegalPerson: undefined,
    status: undefined,
    remarks: undefined,
  },
  // 表单校验
  rules: {
    customerCode: [
      { required: true, message: "客户编号不能为空", trigger: "blur" },
      { max: 30, message: "客户编号长度不能大于 30 ", trigger: "blur" },
    ],
    customerName: [
      { required: true, message: "客户名称不能为空", trigger: "blur" },
      { max: 30, message: "客户名称长度不能大于 30 ", trigger: "blur" },
    ],
    status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
    customerEmail: [
      {
        type: "email",
        message: "请输入正确的邮箱地址",
        trigger: ["blur", "change"],
      },
    ],
    customerContactNumber: [
      {
        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
        message: "请输入正确的手机号码",
        trigger: "blur",
      },
    ],
  },
})

const {
  customerForm,
  form,
  rules,
} = toRefs(data);

// 监听visible变化重置表单
watch(() => props.visible, (newVal) => {
  if (newVal) {
    Object.assign(customerForm, {
      customerCode: undefined,
      customerName: undefined,
      customerSalesPerson: undefined,
      customerContacts: undefined,
      customerContactNumber: undefined,
      customerWorkAddress: undefined,
      customerPostalCode: undefined,
      customerOpeningDebt: undefined,
      customerOpeningBank: undefined,
      customerAccountNumber: undefined,
      customerTaxId: undefined,
      customerCompanyHomepage: undefined,
      customerEmail: undefined,
      customerLegalPerson: undefined,
      status: undefined,
      remarks: undefined,
    })
    proxy.resetForm('customerRef')
  }
})

/** 重置操作客户表单 */
function customerReset() {
  form.value = {
    customerCode: undefined,
    customerName: undefined,
    customerSalesPerson: undefined,
    customerContacts: undefined,
    customerContactNumber: undefined,
    customerWorkAddress: undefined,
    customerPostalCode: undefined,
    customerOpeningDebt: undefined,
    customerOpeningBank: undefined,
    customerAccountNumber: undefined,
    customerTaxId: undefined,
    customerCompanyHomepage: undefined,
    customerEmail: undefined,
    customerLegalPerson: undefined,
    status: undefined,
    remarks: undefined,
  };
  proxy.resetForm("customerRef");
}

/** 提交客户按钮 */
function submitCustomerForm() {
  proxy.$refs["customerRef"].validate((valid) => {
    if (valid) {
      addCustomer(customerForm.value);
      proxy.$modal.msgSuccess(
          "已新增编号为" + customerForm.value.customerCode + "的客户"
      );
      cancelCustomerForm();
    }
  });
}
/** 取消客户按钮 */
function cancelCustomerForm() {
  emit('update:visible', false)
  customerReset()
}
</script>


<style scoped>
.form-item {
  width: 200px;
}
.footer {
  text-align: center;
}
</style>