<template>
  <div>
    <el-row :gutter="5">
      <el-col :span="24">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>采购管理</span>
            </div>
          </template>
          <el-tabs tab-position="left" class="demo-tabs">
            <el-tab-pane label="采购订单制作">
              <el-descriptions
                class="margin-top"
                direction="vertical"
                title="总览"
                :column="3"
                :size="size"
                border
              >
                <el-descriptions-item label="采购订单制作页面图片" :span="1"
                  ><el-image
                    style="width: 100px; height: 100px"
                    :src="url"
                    :zoom-rate="1.2"
                    :max-scale="7"
                    :min-scale="0.2"
                    :preview-src-list="srcList"
                    :initial-index="4"
                    fit="cover"
                /></el-descriptions-item>
                <el-descriptions-item label="采购订单业务流程" :span="2"
                  ><el-steps style="max-width: 100%">
                    <el-step title="新建订单" />
                    <el-step title="填写订单信息" />
                    <el-step title="保存订单" />
                    <el-step title="待审核" description="订单状态" />
                    <el-step title="审核订单" />
                    <el-step title="已审核" description="订单状态" />
                    <el-step
                      title="创建"
                      description="采购入库单据"
                    /> </el-steps
                ></el-descriptions-item>
              </el-descriptions>
              <el-descriptions
                class="margin-top"
                title="填写信息"
                :column="3"
                :size="size"
                border
              >
                <el-descriptions-item label="系统单号"
                  >系统唯一标识，自动生成且不能修改，生成规则:CR-年-月-日-时分秒。</el-descriptions-item
                >
                <el-descriptions-item label="原始单号"
                  >供应商的订单单号，用于系统订单与供应商订单关联，方便后续核对。</el-descriptions-item
                >
                <el-descriptions-item label="订单类型"
                  >订单的类型，区分订单属于采购还是销售，该页面为采购订单。</el-descriptions-item
                >
                <el-descriptions-item label="订单状态"
                  >订单的流程状态，首次创建订单为待审核，已审核代表获得财务认可。</el-descriptions-item
                >
                <el-descriptions-item label="订货日期"
                  >订购供应商货品的日期，默认显示为当天。</el-descriptions-item
                >
                <el-descriptions-item label="交货日期"
                  >收到供应商货品的日期，默认显示为当天。</el-descriptions-item
                >
                <el-descriptions-item label="仓库"
                  >选择全部货品搬入哪个仓库，未维护请移步至仓库资料，需必选。</el-descriptions-item
                >
                <el-descriptions-item label="经手人"
                  >采购订单承办人，如果看不到则无法选择其他人，默认登录该系统的人。</el-descriptions-item
                >
                <el-descriptions-item label="供应商"
                  >选择采购订单对应的供应商，未维护请移步至供应商资料，需必选。</el-descriptions-item
                >
                <el-descriptions-item label="备注"
                  >附加注解说明，记录特殊采购订单信息。</el-descriptions-item
                >
                <el-descriptions-item label="定金"
                  >预先付款给供应商的金额。</el-descriptions-item
                >
                <el-descriptions-item label="总金额"
                  >货品明细全部货品金额汇总值，显示数字。</el-descriptions-item
                >
                <el-descriptions-item label="总金额（大写）"
                  >货品明细全部货品金额汇总值，显示大写。</el-descriptions-item
                >
                <el-descriptions-item label="采购入库单据"
                  >是否创建/更新采购入库单据，财务审核订单后，系统根据选择进行处理。</el-descriptions-item
                >
                <el-descriptions-item label="审核结果"
                  >财务审核结果，通过代表财务认可，不通过代表订单信息有问题请查看审核意见，创建订单时无显示，保存订单后方可查看。</el-descriptions-item
                >
                <el-descriptions-item label="审核意见"
                  >财务审核采购订单的意见与修改建议，创建订单时无显示，保存订单后方可查看。</el-descriptions-item
                >
                <el-descriptions-item label="货品明细"
                  >订单的货品明细，添加货品后选择货品，可自定义修改规格与单位不影响货品数据，填写数量、单价、折扣，计算规则：金额=数量*单价*折扣，成本=数量*单价*折扣。</el-descriptions-item
                >
              </el-descriptions>
              <el-descriptions
                class="margin-top"
                title="可用按钮"
                :column="3"
                :size="size"
                border
              >
                <el-descriptions-item label="添加货品"
                  >货品明细添加入库的货品，点击一次则会新增一行在货品编号/名称选择货品。</el-descriptions-item
                >
                <el-descriptions-item label="新增货品"
                  >增加供应商新进未录入系统的货品，新增后可在货品编号/名称进行选择。</el-descriptions-item
                >
                <el-descriptions-item label="保存"
                  >保存采购订单，等待财务审核。</el-descriptions-item
                >
                <el-descriptions-item label="审核"
                  >审核采购订单，将根据选择是否创建/更新采购入库单据，审核有问题请填写审核意见，点击保存。</el-descriptions-item
                >
                <el-descriptions-item label="删除"
                  >删除订单，返回订单查询</el-descriptions-item
                >
                <el-descriptions-item label="取消"
                  >取消订单制作，返回订单查询</el-descriptions-item
                >
              </el-descriptions>
            </el-tab-pane>
            <el-tab-pane label="采购单据制作">
              <el-descriptions
                class="margin-top"
                direction="vertical"
                title="筛选条件"
                :column="3"
                :size="size"
                border
              >
                <el-descriptions-item label="采购单据制作页面图片" :span="1"
                  ><el-image
                    style="width: 100px; height: 100px"
                    :src="url"
                    :zoom-rate="1.2"
                    :max-scale="7"
                    :min-scale="0.2"
                    :preview-src-list="srcList"
                    :initial-index="4"
                    fit="cover"
                /></el-descriptions-item>
                <el-descriptions-item label="采购单据业务流程" :span="2"
                  ><el-steps style="max-width: 100%">
                    <el-step title="新增单据" />
                    <el-step title="选择单据类型" />
                    <el-step title="填写单据信息" />
                    <el-step title="保存单据" />
                    <el-step title="待审核" description="单据状态" />
                    <el-step title="审核单据" />
                    <el-step title="已审核" description="单据状态" />
                    <el-step title="创建" description="售后单据" /> </el-steps
                ></el-descriptions-item>
              </el-descriptions>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
const url =
  "https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg";
const srcList = [
  "https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg",
  "https://fuss10.elemecdn.com/1/34/19aa98b1fcb2781c4fba33d850549jpeg.jpeg",
  "https://fuss10.elemecdn.com/0/6f/e35ff375812e6b0020b6b4e8f9583jpeg.jpeg",
  "https://fuss10.elemecdn.com/9/bb/e27858e973f5d7d3904835f46abbdjpeg.jpeg",
  "https://fuss10.elemecdn.com/d/e6/c4d93a3805b3ce3f323f7974e6f78jpeg.jpeg",
  "https://fuss10.elemecdn.com/3/28/bbf893f792f03a54408b3b7a7ebf0jpeg.jpeg",
  "https://fuss10.elemecdn.com/2/11/6535bcfb26e4c79b48ddde44f4b6fjpeg.jpeg",
];
</script>

<style scoped>
.demo-image__error .image-slot {
  font-size: 30px;
}
.demo-image__error .image-slot .el-icon {
  font-size: 30px;
}
.demo-image__error .el-image {
  width: 100%;
  height: 200px;
}
.demo-tabs > .el-tabs__content {
  padding: 32px;
  color: #6b778c;
  font-size: 32px;
  font-weight: 600;
}

.el-tabs--right .el-tabs__content,
.el-tabs--left .el-tabs__content {
  height: 100%;
}
</style>
