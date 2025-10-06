<template>
  <!--模板列表与编辑页面-->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <!-- 查询表单 -->
        <el-form
            :inline="true"
            v-show="showSearch"
            ref="queryRef"
            :model="queryParams"
            label-width="90px"
        >
          <el-form-item label="模板名称" prop="templateName">
            <el-input
                v-model="queryParams.templateName"
                placeholder="请输入模板名称"
                style="width: 200px"
                clearable
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="Search" @click="handleQuery">查询</el-button>
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <!-- 操作按钮 -->
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
                type="primary"
                plain
                icon="Plus"
                @click="handleAdd"
                v-hasPermi="['print:template:add']"
            >新增</el-button>
          </el-col>
          <right-toolbar
              v-model:showSearch="showSearch"
              @queryTable="getList"
          ></right-toolbar>
        </el-row>

        <!-- 表格数据 -->
        <el-table border v-loading="loading" :data="templateList">
          <el-table-column label="模板ID" align="center" prop="templateId" width="70"/>
          <el-table-column label="模板名称" align="center" prop="templateName" />
          <el-table-column label="备注" align="center" prop="remark" width="200"/>
          <el-table-column label="创建者" align="center" prop="createBy" width="100" />
          <el-table-column label="创建时间" align="center" prop="createTime" width="180">
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="更新者" align="center" prop="updateBy" width="100" />
          <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
            <template #default="scope">
              <el-tooltip content="预览" placement="top">
                <el-button
                    link
                    type="info"
                    icon="View"
                    @click="handlePreview(scope.row)"
                    v-hasPermi="['print:template:preview']"
                >预览</el-button>
              </el-tooltip>
              <el-tooltip content="修改" placement="top">
                <el-button
                    link
                    type="primary"
                    icon="Edit"
                    @click="handleUpdate(scope.row)"
                    v-hasPermi="['print:template:edit']"
                >修改</el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                    link
                    type="danger"
                    icon="Delete"
                    @click="handleDelete(scope.row)"
                    v-hasPermi="['print:template:remove']"
                >删除</el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>

        <!-- 分页 -->
        <pagination
            v-show="total > 0"
            :total="total"
            v-model:page="queryParams.pageNum"
            v-model:limit="queryParams.pageSize"
            @pagination="getList"
        />
      </el-col>
    </el-row>

    <!-- 编辑/新增对话框 -->
    <el-dialog
        :title="dialogTitle"
        v-model="open"
        width="70%"
        @close="handleDialogClose"
    >
      <el-form :model="form" ref="orderRef" :rules="rules" label-width="100px">
        <el-form-item label="模板名称" prop="templateName">
          <el-input v-model="form.templateName" placeholder="请输入模板名称"/>
        </el-form-item>
        <el-form-item label="JS代码" prop="jsContent">
          <el-input
              v-model="form.jsContent"
              type="textarea"
              :rows="15"
              placeholder="请输入JS内容"
          />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
              v-model="form.remark"
              type="textarea"
              :rows="2"
              placeholder="请输入备注（可选）"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="save">保存</el-button>
          <el-button @click="open = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 模板预览对话框 -->
    <el-dialog
        title="模板预览"
        v-model="previewOpen"
        width="80%"
        :close-on-click-modal="false"
        append-to-body
    >
      <div
          ref="previewContainer"
          class="template-preview-container"
          :style="{ height: '600px', overflow: 'auto', border: '1px solid #eee' }"
      ></div>
    </el-dialog>

  </div>
</template>

<script setup>
import { ref, reactive, getCurrentInstance, toRefs } from 'vue'
import { listTemplate, getTemplate, delTemplate, addTemplate, updateTemplate } from '@/api/print/template'
import { useRouter } from 'vue-router'
import {getReceipt} from "@/api/inventory/inventoryDocumentQuery";
import VxeUI from 'vxe-table'

window.VxeUI = VxeUI

const { proxy } = getCurrentInstance()
const router = useRouter()

// 表格相关
const templateList = ref([])
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)
const dateRange = ref([])

// 对话框相关
const open = ref(false)
const isEdit = ref(false) // true 表示编辑，false 表示新增

// 预览相关
const previewOpen = ref(false)
const previewContainer = ref(null)
const previewData = ref(null)


// 查询参数
const queryParams = reactive({
  pageNum: 1,
  pageSize: 50,
  templateName: undefined
})

// 表单数据
const form = reactive({
  templateId: undefined,
  templateName: undefined,
  htmlContent: undefined,
  cssContent: undefined,
  jsContent: undefined,
  remark: undefined,
})

// 表单校验规则
const rules = reactive({
  templateName: [{ required: true, message: '模板名称不能为空', trigger: 'blur' }],
  jsContent: [{ required: true, message: 'JS代码不能为空', trigger: 'blur' }],
})

// 对话框标题
const dialogTitle = computed(() => isEdit.value ? '修改模板' : '新增模板')

// 获取列表
function getList() {
  loading.value = true
  listTemplate(proxy.addDateRange(queryParams, dateRange.value)).then(response => {
    templateList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

// 查询
function handleQuery() {
  queryParams.pageNum = 1
  getList()
}

// 重置
function resetQuery() {
  dateRange.value = []
  proxy.resetForm('queryRef')
  handleQuery()
}

// 新增
function handleAdd() {
  isEdit.value = false
  Object.assign(form, {
    templateId: undefined,
    templateName: undefined,
    jsContent: undefined,
    remark: undefined,
  })
  open.value = true
}

// 修改
function handleUpdate(row) {
  isEdit.value = true
  getTemplate(row.templateId).then(response => {
    Object.assign(form, response.data)
    open.value = true
  })
}

// 删除
function handleDelete(row) {
  proxy.$modal.confirm(`确认要删除ID为${row.templateId}的打印模板?`).then(() => {
    return delTemplate(row.templateId)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  }).catch(() => {})
}

// 保存
function save() {
  proxy.$refs['orderRef'].validate(valid => {
    if (valid) {
      const api = isEdit.value ? updateTemplate : addTemplate
      api(form).then(() => {
        proxy.$modal.msgSuccess('保存成功')
        open.value = false
        getList()
      })
    }
  })
}

// 关闭对话框时重置表单（可选）
function handleDialogClose() {
  proxy.$refs['orderRef']?.resetFields()
}

function handlePreview(row) {
  // 创建示例数据
  const exampleData = {
    data: {
      originalReceipt: '20231001001',
      systematicReceipt: 'SYS20231001001',
      invoiceDate: '2023-10-01',
      customer: { customerName: '测试客户有限公司' },
      details: [
        {
          productCode: 'P001',
          productName: '不锈钢螺丝',
          productSpecifications: 'M6x50mm',
          measureUnit: '个',
          planQuantity: '100',
          univalence: '0.50',
          money: '50.00',
          remarks: '标准件'
        },
        {
          productCode: 'P002',
          productName: '铝合金板',
          productSpecifications: '100x50x5mm',
          measureUnit: '张',
          planQuantity: '50',
          univalence: '20.00',
          money: '1000.00',
          remarks: '特殊规格'
        }
      ],
      sysUser: { userName: '张三' },
      receiptNotes: '请于2023-10-05前送达'
    }
  }

  try {
    // 1. 确保有JS代码
    if (!row.jsContent) {
      alert('模板JS代码为空')
      return
    }

    // 2. 直接执行模板代码（使用全局VxeUI）
    try {
      const templateFnFactory = new Function(`${row.jsContent}`);
      const templateFn = templateFnFactory();
      if (typeof templateFn === 'function') {
        alert('预览已触发打印！请在浏览器打印对话框中确认打印设置，数据为模拟数据。请放心！')
        templateFn(exampleData);
      } else {
        throw new Error('模板未返回有效函数');
      }
    } catch (e) {
      console.error('模板执行失败:', e);
      proxy.$modal.msgError(`执行失败: ${e.message}`);
    }
  } catch (e) {
    alert(`预览失败: ${e.message}`)
  }
}

// 初始化
getList()
</script>

<style scoped>
:deep(.template-preview-container *) {
  box-sizing: border-box;
}

.preview-loading {
  text-align: center;
  padding: 20px;
  color: #666;
}

.preview-error {
  text-align: center;
  padding: 20px;
  color: #e53935;
  background: #ffebee;
  border-radius: 4px;
}

.preview-error {
  text-align: center;
  padding: 20px;
  color: #d32f2f;
  background: #ffebee;
  border-radius: 4px;
  font-weight: bold;
  line-height: 1.5;
}
</style>