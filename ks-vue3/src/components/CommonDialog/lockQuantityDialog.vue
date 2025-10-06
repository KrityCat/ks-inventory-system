<!-- 入库锁单数量查询配置对话框 -->
<template>
  <el-dialog
      :model-value="visible"
      :title="titleLockQuantity"
      append-to-body
      width="80%"
      @update:modelValue="$emit('update:visible', $event)"
  >
    <el-table v-loading="loading" :data="tableData" border>
      <el-table-column
          align="center"
          label="序号"
          type="index"
          width="60"
      />
      <el-table-column
          align="center"
          label="系统编号"
          prop="systematicReceipt"
      />
      <el-table-column
          align="center"
          label="开单日期"
          prop="headReceipt.invoiceDate"
      />
      <el-table-column
          align="center"
          label="经手人"
          prop="sysUser.userName"
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
          label="数量"
          prop="planQuantity"
      />
    </el-table>
  </el-dialog>
</template>

<script setup>
import {defineEmits, defineProps, ref, watch} from "vue";
import {selectLockQtyQuery} from "@/api/common/CommonReceipt";

const props = defineProps({
  visible: Boolean,
  productId: String,
  warehousingId: String,
  retrievalId: String,
});

// 本地数据状态
const tableData = ref([]);
const loading = ref(false);
const emit = defineEmits(['update:visible', 'success'])

const titleLockQuantity = ref("查看货品单据锁单数量");

watch(
    () => props.visible,
    async (newVal) => {
      if (newVal && props.productId) {
        try {
          loading.value = true;
          const response = await selectLockQtyQuery({
            productId: props.productId,
            warehousingId: props.warehousingId || 0,
            retrievalId: props.retrievalId || 0,
            pageSize: 50
          });
          tableData.value = response.rows || [];
          if (response.rows === undefined) {
            proxy.$modal.msgError("暂无权限");
          }
        } catch (e) {
          console.error('数据加载失败:', e);
          tableData.value = [];
        } finally {
          loading.value = false;
        }
      } else {
        tableData.value = [];
      }
    },
    {immediate: true}
);

</script>


<style scoped>
.form-item {
  width: 200px;
}

.footer {
  text-align: center;
}
</style>