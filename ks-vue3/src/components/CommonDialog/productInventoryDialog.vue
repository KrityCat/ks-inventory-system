<!-- 查看货品库存数量配置对话框 -->
<template>
  <el-dialog
      :title="titleProductInventory"
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
          label="仓库"
          align="center"
          prop="warehouse.warehouseName"
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
      <el-table-column
          label="单价"
          align="center"
          prop="univalence"
      />
      <el-table-column
          label="金额"
          align="center"
          prop="money"
      />
    </el-table>
  </el-dialog>
</template>

<script setup>
import {defineEmits, defineProps, ref, watch } from "vue";
import { selectInventoryQtyQuery } from "@/api/common/CommonReceipt";

const { proxy } = getCurrentInstance();

const props = defineProps({
  visible: Boolean,
  productId: String
});

// 本地数据状态
const tableData = ref([]);
const loading = ref(false);
const emit = defineEmits(['update:visible', 'success'])

const titleProductInventory = ref("查看货品所有仓库数量");

watch(
    () => props.visible,
    async (newVal) => {
      if (newVal && props.productId) {
        try {
          loading.value = true;
          const response = await selectInventoryQtyQuery({
            productId: props.productId,
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