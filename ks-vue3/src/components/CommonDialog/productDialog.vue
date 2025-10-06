<!-- 添加货品配置对话框 -->
<template>
  <el-dialog
      :title="titleProduct"
      :model-value="visible"
      @update:modelValue="$emit('update:visible', $event)"
      width="700px"
      append-to-body
  >
    <el-form
        :model="productForm"
        :rules="rules"
        ref="productRef"
        label-width="80px"
    >
      <el-row>
        <el-col :span="12">
          <el-form-item label="货品编号" prop="productCode">
            <el-input
                v-model="productForm.productCode"
                placeholder="请输入货品编号"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="货品名称" prop="productName">
            <el-input
                v-model="productForm.productName"
                placeholder="请输入货品名称"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="货品类型" prop="productType">
            <el-tree-select
                v-model="productForm.productType"
                :data="typeOptions"
                :props="{ value: 'id', label: 'label', children: 'children' }"
                value-key="id"
                placeholder="请选择货品类型"
                check-strictly
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="货品规格" prop="productSpecifications">
            <el-input
                v-model="productForm.productSpecifications"
                placeholder="请输入货品规格"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="计量单位" prop="measureUnit">
            <el-input
                v-model="productForm.measureUnit"
                placeholder="请输入计量单位"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="货品条码" prop="productBarcode">
            <el-input
                v-model="productForm.productBarcode"
                placeholder="请输入货品条码"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <el-form-item label="产地" prop="producer">
            <el-input
                v-model="productForm.producer"
                placeholder="请输入产地"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="成本价" prop="costPrice">
            <el-input
                v-model="productForm.costPrice"
                placeholder="请输入成本价"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="参考售价" prop="univalence">
            <el-input
                v-model="productForm.univalence"
                placeholder="请输入参考售价"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="销售折扣" prop="discount">
            <el-input
                v-model="productForm.discount"
                placeholder="请输入销售折扣"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="库存数量" prop="costPrice">
            <el-input
                v-model="productForm.inventoryQty"
                placeholder="系统自动计算"
                disabled
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="库存上限" prop="upperLimit">
            <el-input
                v-model="productForm.upperLimit"
                placeholder="请输入库存上限"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="库存下限" prop="lowerLimit">
            <el-input
                v-model="productForm.lowerLimit"
                placeholder="请输入库存下限"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="默认仓库" prop="defaultWarehouse">
            <el-input
                v-model="productForm.defaultWarehouse"
                placeholder="请输入默认仓库"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status">
            <el-select
                v-model="productForm.status"
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
          <el-form-item label="备注">
            <el-input
                v-model="productForm.notes"
                type="textarea"
                placeholder="请输入内容"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button type="primary" @click="submitProductForm">确 定</el-button>
        <el-button @click="cancelProductForm">取 消</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import {
  addProduct,
  listProduct,
  productTypeTreeSelect,
} from "@/api/basedate/product";
import {defineEmits, defineProps, ref} from "vue";

const props = defineProps({ visible: Boolean })
const emit = defineEmits(['update:visible', 'success'])

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

const titleProduct = ref("新增货品");

const data = reactive({
  typeOptions: undefined,
  productForm: {
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    measureUnit: undefined,
    producer: undefined,
    costPrice: undefined,
    univalence: undefined,
    discount: undefined,
    productBarcode: undefined,
    upperLimit: undefined,
    lowerLimit: undefined,
    defaultWarehouse: undefined,
    notes: undefined,
    status: undefined,
  },
  // 表单校验
  rules: {
    status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
    productCode: [
      { required: true, message: "货品编号不能为空", trigger: "blur" },
    ],
    productName: [
      { required: true, message: "货品名称不能为空", trigger: "blur" },
    ],
    productType: [
      { required: true, message: "货品类型不能为空", trigger: "blur" },
    ],
    productSpecifications: [
      { required: true, message: "货品规格不能为空", trigger: "blur" },
    ],
    measureUnit: [
      { required: true, message: "计量单位不能为空", trigger: "blur" },
    ],
  },
})

const {
  productOptions,
  typeOptions,
  option,
  productForm,
  form,
  rules,
} = toRefs(data);

// 监听visible变化重置表单
watch(() => props.visible, (newVal) => {
  if (newVal) {
    Object.assign(productForm, {
      productId: undefined,
      productCode: undefined,
      productName: undefined,
      productType: undefined,
      productSpecifications: undefined,
      measureUnit: undefined,
      phonenumber: undefined,
      producer: undefined,
      costPrice: undefined,
      univalence: undefined,
      discount: undefined,
      productBarcode: undefined,
      upperLimit: undefined,
      lowerLimit: undefined,
      defaultWarehouse: undefined,
      notes: undefined,
      status: undefined,
    })
    proxy.resetForm('productRef')
  }
})


/** 重置操作货品表单 */
function productReset() {
  productForm.value = {
    productId: undefined,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    measureUnit: undefined,
    phonenumber: undefined,
    producer: undefined,
    costPrice: undefined,
    univalence: undefined,
    discount: undefined,
    productBarcode: undefined,
    upperLimit: undefined,
    lowerLimit: undefined,
    defaultWarehouse: undefined,
    notes: undefined,
    status: undefined,
  };
  proxy.resetForm("productRef");
}

/** 查询货品类型下拉树结构 */
function getProductTypeTree() {
  productTypeTreeSelect().then((response) => {
    typeOptions.value = response.data;
  });
}


/** 提交货品按钮 */
function submitProductForm() {
  proxy.$refs["productRef"].validate((valid) => {
    if (valid) {
      addProduct(productForm.value);
      proxy.$modal.msgSuccess(
          "已新增编号为" + productForm.value.productCode + "的货品"
      );
      cancelProductForm()
    }
  });
}
/** 取消货品按钮 */
function cancelProductForm() {
  emit('update:visible', false)
  productReset()
}
getProductTypeTree()
</script>


<style scoped>
.form-item {
  width: 200px;
}
.footer {
  text-align: center;
}
</style>