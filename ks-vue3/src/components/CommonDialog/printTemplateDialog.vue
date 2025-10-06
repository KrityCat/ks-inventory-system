<!-- 查看货品库存数量配置对话框 -->
<template>
  <el-dialog
      :title="titlePrintTemplate"
      :model-value="visible"
      @update:modelValue="$emit('update:visible', $event)"
      width="30%"
      append-to-body
  >
    <el-table border v-loading="loading" :data="templateList">
      <el-table-column label="模板ID" align="center" prop="templateId" width="70"/>
      <el-table-column label="模板名称" align="center" prop="templateName" />
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-tooltip content="打印" placement="top">
            <el-button
                link
                type="info"
                icon="View"
                @click="handlePreview(scope.row)"
            >打印</el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>
  </el-dialog>
</template>

<script setup>
import {defineEmits, defineProps, reactive, ref, watch} from "vue";
import VxeUI from 'vxe-table'
import {selectPrintQuery, getReceipt} from "@/api/common/CommonReceipt";

window.VxeUI = VxeUI

const { proxy } = getCurrentInstance();

const props = defineProps({
  visible: Boolean,
  systematicReceipt: String
});

// 本地数据状态
const templateList = ref([])
const tableData = ref([]);
const loading = ref(false);
const total = ref(0)
const dateRange = ref([])
const emit = defineEmits(['update:visible', 'success'])

const titlePrintTemplate = ref("打印模板选择");

const queryParams = reactive({
  pageNum: 1,
  pageSize: 50,
  templateName: undefined,
  systematicReceipt: undefined,
})

watch(
    () => props.visible,
    (newVal) => {
      if (newVal) {
        // 每次打开都同步最新的 systematicReceipt
        queryParams.systematicReceipt = props.systematicReceipt;
        getList(); // 别忘了重新加载列表（你原来没调用！）
      }
    },
    { immediate: true }
);

function getList() {
  loading.value = true
  selectPrintQuery(proxy.addDateRange(queryParams, dateRange.value)).then(response => {
    templateList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function handlePreview(row) {
  const systematicReceipt = queryParams.systematicReceipt;
  console.log(systematicReceipt);

  try {
    // 1. 确保有JS代码
    if (!row.jsContent) {
      alert('模板JS代码为空')
      return
    }
    getReceipt(queryParams.systematicReceipt)
        .then((response) => {
          try {
            const templateFnFactory = new Function(`${row.jsContent}`);
            const templateFn = templateFnFactory();
            if (typeof templateFn === 'function') {
              templateFn(response);
            } else {
              throw new Error('模板未返回有效函数');
            }
          } catch (e) {
            console.error('模板执行失败:', e);
            proxy.$modal.msgError(`执行失败: ${e.message}`);
          }
        })
        .catch(() => {
          proxy.$modal.msgError('获取打印数据失败');
        });
  } catch (e) {
    alert(`预览失败: ${e.message}`)
  }
}

getList();
</script>


<style scoped>
.form-item {
  width: 200px;
}
.footer {
  text-align: center;
}
</style>