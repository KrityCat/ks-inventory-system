<template>
  <div class="print-template-container">
    <!-- 控制栏 -->
    <div class="toolbar">
      <el-button @click="exportToExcel" class="export-btn">导出 Excel (.xlsx)</el-button>
    </div>

    <!-- 主内容区域 -->
    <div class="main-content">
      <!-- Luckysheet容器 -->
      <div id="luckysheet" class="luckysheet-container"></div>
    </div>

  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as XLSX from 'xlsx'

// 初始化Luckysheet
const initLuckysheet = () => {
  const container = document.getElementById('luckysheet')
  if (!container) return

  container.style.height = 'calc(100vh - 150px)'

  luckysheet.create({
    container: 'luckysheet',
    lang: 'zh',
    title: '在线表格使用',
    default: {
      sheetName: '模板1'
    },
    height: 'calc(100vh - 150px)',
    width: '100%'
  })
}

// 导出为 Excel (.xlsx)
const exportToExcel = () => {
  try {
    // 获取当前所有 sheet 数据
    const sheetData = luckysheet.getAllSheets()

    // 创建一个新的 workbook
    const wb = XLSX.utils.book_new()

    // 遍历每个 sheet
    sheetData.forEach((sheet) => {
      const sheetName = sheet.name || 'Sheet1'

      // 将二维数据数组转为 worksheet
      // 注意：luckysheet 的 data 是二维数组，但可能有 null/undefined，需处理
      const data = sheet.data || []

      // 补全空行/空列（可选，避免缺失）
      const cleanData = data.map(row =>
          (row || []).map(cell => {
            if (cell == null) return ''
            return typeof cell === 'object' ? (cell.v != null ? cell.v : '') : cell
          })
      )

      const ws = XLSX.utils.aoa_to_sheet(cleanData)
      XLSX.utils.book_append_sheet(wb, ws, sheetName)
    })

    // 导出文件
    XLSX.writeFile(wb, '铠思系统在线表格导出.xlsx')
  } catch (error) {
    console.error('导出 Excel 失败:', error)
    alert('导出失败，请检查控制台')
  }
}

// 生命周期
onMounted(() => {
  initLuckysheet()
})

onBeforeUnmount(() => {
  if (typeof luckysheet !== 'undefined' && luckysheet.destroy) {
    luckysheet.destroy()
  }
})
</script>

<style scoped>
.print-template-container {
  width: 100%;
  height: 90vh;
  display: flex;
  flex-direction: column;
  padding: 10px;
  box-sizing: border-box;
  overflow: hidden;
}

.main-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 10px;
  overflow: hidden;
}

.luckysheet-container {
  flex: 1;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  overflow: hidden;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  background-color: #fff;
  height: calc(100% - 50px);
}

.toolbar {
  display: flex;
  justify-content: flex-end;
  padding-bottom: 10px;
}

.export-btn {
  padding: 6px 12px;
  background-color: #409eff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.export-btn:hover {
  background-color: #54a3ff;
}
</style>