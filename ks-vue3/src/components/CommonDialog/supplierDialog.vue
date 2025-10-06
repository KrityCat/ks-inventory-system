<!-- 添加供应商配置对话框 -->
<template>
  <el-dialog
      :title="titleSupplier"
      :model-value="visible"
      @update:modelValue="$emit('update:visible', $event)"
      width="700px"
      append-to-body
  >
    <el-form
        :model="supplierForm"
        :rules="rules"
        ref="supplierRef"
        label-width="100px"
    >
      <el-row>
        <el-col :span="12">
          <el-form-item label="供应商编号" prop="supplierCode">
            <el-input
                v-model="supplierForm.supplierCode"
                placeholder="请输入供应商编号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="供应商名称" prop="supplierName">
            <el-input
                v-model="supplierForm.supplierName"
                placeholder="请输入供应商名称"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="业务员" prop="supplierSalesPerson">
            <el-input
                v-model="supplierForm.supplierSalesPerson"
                placeholder="请输入业务员"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系人" prop="supplierContacts">
            <el-input
                v-model="supplierForm.supplierContacts"
                placeholder="请输入联系人"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="联系电话" prop="supplierContactNumber">
            <el-input
                v-model="supplierForm.supplierContactNumber"
                placeholder="请输入联系电话"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="邮编" prop="supplierPostalCode">
            <el-input
                v-model="supplierForm.supplierPostalCode"
                placeholder="请输入邮编"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="期初欠款" prop="supplierOpeningDebt">
            <el-input
                v-model="supplierForm.supplierOpeningDebt"
                placeholder="请输入期初欠款"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="开户银行" prop="supplierOpeningBank">
            <el-input
                v-model="supplierForm.supplierOpeningBank"
                placeholder="请输入开户银行"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="银行账号" prop="supplierAccountNumber">
            <el-input
                v-model="supplierForm.supplierAccountNumber"
                placeholder="请输入银行账号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="纳税号" prop="supplierTaxId">
            <el-input
                v-model="supplierForm.supplierTaxId"
                placeholder="请输入纳税号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="公司主页" prop="supplierCompanyHomepage">
            <el-input
                v-model="supplierForm.supplierCompanyHomepage"
                placeholder="请输入公司主页"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="电子邮箱" prop="supplierEmail">
            <el-input
                v-model="supplierForm.supplierEmail"
                placeholder="请输入电子邮箱"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="公司法人" prop="supplierLegalPerson">
            <el-input
                v-model="supplierForm.supplierLegalPerson"
                placeholder="请输入公司法人"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status">
            <el-select
                v-model="supplierForm.status"
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
          <el-form-item label="单位地址" prop="supplierWorkAddress">
            <el-input
                v-model="supplierForm.supplierWorkAddress"
                placeholder="请输入单位地址"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <el-form-item label="备注">
            <el-input
                v-model="supplierForm.remarks"
                type="textarea"
                placeholder="请输入备注"
            />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button type="primary" @click="submitSupplierForm">确 定</el-button>
        <el-button @click="cancelSupplierForm">取 消</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive, watch, defineProps, defineEmits } from 'vue'
import { addSupplier } from "@/api/basedate/supplier";

const props = defineProps({ visible: Boolean })
const emit = defineEmits(['update:visible', 'success'])

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

const titleSupplier = ref("新增供应商");

const data = reactive({
  supplierOptions: undefined,
  supplierForm: {
    supplierCode: undefined,
    supplierName: undefined,
    supplierSalesPerson: undefined,
    supplierContacts: undefined,
    supplierContactNumber: undefined,
    supplierWorkAddress: undefined,
    supplierPostalCode: undefined,
    supplierOpeningDebt: undefined,
    supplierOpeningBank: undefined,
    supplierAccountNumber: undefined,
    supplierTaxId: undefined,
    supplierCompanyHomepage: undefined,
    supplierEmail: undefined,
    supplierLegalPerson: undefined,
    status: undefined,
    remarks: undefined,
  },
  rules: {
    supplierIds: [
      { required: true, message: "供应商不能为空", trigger: "blur" },
    ],
    deliveryDate: [
      { required: true, message: "开单日期不能为空", trigger: "blur" },
    ],
    supplierCode: [
      { required: true, message: "供应商编号不能为空", trigger: "blur" },
      { max: 30, message: "供应商编号长度不能大于 30 ", trigger: "blur" },
    ],
    supplierName: [
      { required: true, message: "供应商名称不能为空", trigger: "blur" },
      { max: 30, message: "供应商名称长度不能大于 30 ", trigger: "blur" },
    ],
    status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
    supplierEmail: [
      {
        type: "email",
        message: "请输入正确的邮箱地址",
        trigger: ["blur", "change"],
      },
    ],
    supplierContactNumber: [
      {
        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
        message: "请输入正确的手机号码",
        trigger: "blur",
      },
    ],
  }
});

const {
  supplierForm,
  rules,
} = toRefs(data);

// 监听visible变化重置表单
watch(() => props.visible, (newVal) => {
  if (newVal) {
    Object.assign(supplierForm, {
      supplierCode: undefined,
      supplierName: undefined,
      supplierSalesPerson: undefined,
      supplierContacts: undefined,
      supplierContactNumber: undefined,
      supplierWorkAddress: undefined,
      supplierPostalCode: undefined,
      supplierOpeningDebt: undefined,
      supplierOpeningBank: undefined,
      supplierAccountNumber: undefined,
      supplierTaxId: undefined,
      supplierCompanyHomepage: undefined,
      supplierEmail: undefined,
      supplierLegalPerson: undefined,
      status: undefined,
      remarks: undefined,
    })
    proxy.resetForm('supplierRef')
  }
})

/** 重置操作供应商表单 */
function supplierReset() {
  supplierForm.value = {
    supplierCode: undefined,
    supplierName: undefined,
    supplierSalesPerson: undefined,
    supplierContacts: undefined,
    supplierContactNumber: undefined,
    supplierWorkAddress: undefined,
    supplierPostalCode: undefined,
    supplierOpeningDebt: undefined,
    supplierOpeningBank: undefined,
    supplierAccountNumber: undefined,
    supplierTaxId: undefined,
    supplierCompanyHomepage: undefined,
    supplierEmail: undefined,
    supplierLegalPerson: undefined,
    status: undefined,
    remarks: undefined,
  };
  proxy.resetForm("supplierRef");
}

/** 提交供应商按钮 */
function submitSupplierForm() {
  proxy.$refs["supplierRef"].validate((valid) => {
    if (valid) {
      addSupplier(supplierForm.value);
      proxy.$modal.msgSuccess(
          "已新增编号为" + supplierForm.value.supplierCode + "的供应商"
      );
      cancelSupplierForm();
    }
  });
}
/** 取消供应商按钮 */
function cancelSupplierForm() {
  emit('update:visible', false)
  supplierReset()
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