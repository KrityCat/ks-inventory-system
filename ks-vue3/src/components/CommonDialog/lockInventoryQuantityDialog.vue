<!-- 入库锁单数量查询配置对话框 -->
<template>
  <el-dialog
      :title="titleLockInventoryQuantity"
      :model-value="visible"
      @update:modelValue="$emit('update:visible', $event)"
      width="80%"
      append-to-body
  >
    <el-table border v-loading="loading" :data="tableData">
      <el-table-column
          label="序号"
          align="center"
          type="index"
          width="60"
      />
      <el-table-column
          label="系统编号"
          align="center"
          prop="systematicReceipt"
      />
      <el-table-column
          label="开单日期"
          align="center"
          prop="headReceipt.invoiceDate"
      />
      <el-table-column
          label="经手人"
          align="center"
          prop="sysUser.userName"
      />
      <el-table-column
          label="货品编号"
          align="center"
          prop="product.productCode"
      />
      <el-table-column
          label="货品名称"
          align="center"
          prop="product.productName"
      />
      <el-table-column
          label="货品类型"
          align="center"
          prop="type.productTypeName"
      />
      <el-table-column
          label="数量"
          align="center"
          prop="planQuantity"
      />
      <el-table-column
          label="锁单数量"
          align="center"
          prop="lockInventoryQty"
      />
    </el-table>
  </el-dialog>
</template>

<script setup>
import {defineEmits, defineProps, ref, watch } from "vue";
import { selectLockInventoryQtyQuery } from "@/api/common/CommonReceipt";

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

const titleLockInventoryQuantity = ref("查看货品入库锁单数量");

watch(
    () => props.visible,
    async (newVal) => {
      if (newVal && props.productId) {
        try {
          loading.value = true;
          const response = await selectLockInventoryQtyQuery({
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
    { immediate: true }
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