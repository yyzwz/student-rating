<template>
<div class="search">
    <Card>
        <Divider>学业发展水平 - 自评问卷</Divider>
        <Form label-position="top">
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="1. 学习用品准备齐全,满分10，自行填写">
                    <InputNumber :max="10" :min="0" v-model="select1" style="width:570px"></InputNumber>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="2. 学习状态佳（入座即学）,满分10，自行填写">
                    <InputNumber :max="10" :min="0" v-model="select2" style="width:570px"></InputNumber>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="3. 遵守课堂纪律,满分10，自行填写">
                    <InputNumber :max="10" :min="0" v-model="select3" style="width:570px"></InputNumber>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="4. 专注听讲">
                    <Select v-model="select4" style="width:570px">
                        <Option value="20">A:优秀</Option>
                        <Option value="15">B:良好</Option>
                        <Option value="10">C:一般</Option>
                        <Option value="5">D:较差</Option>
                        <Option value="0">E:很差</Option>
                    </Select>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="5. 每周课堂回答教师提问的次数是">
                    <Select v-model="select5" style="width:570px">
                        <Option value="20">A:5次以上</Option>
                        <Option value="18">B:3-4次</Option>
                        <Option value="15">C:1-2次</Option>
                        <Option value="10">D:从不</Option>
                    </Select>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="6. 你在抽象概括能力、空间想象能力、推理论证能力、运算求解能力数学基本能力中，有几项是比较强的？">
                    <Select v-model="select6" style="width:570px">
                        <Option value="20">A: 4项</Option>
                        <Option value="15">B: 3项</Option>
                        <Option value="10">C: 2项</Option>
                        <Option value="5">D: 1项</Option>
                        <Option value="0">E: 0项</Option>
                    </Select>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="7. 你认为你的语言表达能力可以得多少分,满分10，自行填写">
                    <InputNumber :max="10" :min="0" v-model="select7" style="width:570px"></InputNumber>
                </FormItem>
                </Col>
            </Row>
            <Row :gitter="16">
                <Button type="success" @click="saveWenJuanFx">提交问卷</Button>
                <Button type="warning" @click="resetForm" style="marginLeft:30px">重置问卷</Button>
            </Row>
        </Form>
    </Card>
</div>
</template>

<script>
import {
    saveOneByType,
    getOneByType,
    editXueYeZiPing
} from "./api.js";
export default {
    name: "single-window",
    components: {},
    data() {
        return {
            select1: 0,
            select2: 0,
            select3: 0,
            select4: "0",
            select5: "0",
            select6: "10",
            select7: 0
        };
    },
    methods: {
        init() {
            this.resetForm();
            this.getOneByTypeFx();
        },
        saveWenJuanFx() {
            var that = this;
            if (isNaN(that.select5)) {
                that.select5 = 0;
            }
            var sum = 0;
            var strAns = "";
            sum += Number(that.select1) + Number(that.select2) + Number(that.select3) + Number(that.select4) + Number(that.select5) + Number(that.select6) + Number(that.select7);
            strAns += that.select1 + "," + that.select2 + "," + that.select3 + "," + that.select4 + "," + that.select5 + "," + that.select6 + "," + that.select7;
            saveOneByType({
                type: 1,
                value: strAns
            }).then(res => {
                if (res.success) {
                    this.$Message.success("问卷保存成功");
                }
            })
            editXueYeZiPing({
                grade: sum
            }).then(res => {
                if (res.success) {
                    this.$Message.success("更新总评价单成功");
                }
            })

        },
        resetForm() {
            this.select1 = 0;
            this.select2 = 0;
            this.select3 = 0;
            this.select4 = "0";
            this.select5 = "0";
            this.select6 = "10";
            this.select7 = 0;
        },
        getOneByTypeFx() {
            var that = this;
            getOneByType({
                type: 1
            }).then(res => {
                if (res.success) {
                    if (res.result.length > 0) {
                        that.select1 = res.result[0];
                        that.select2 = res.result[1];
                        that.select3 = res.result[2];
                        that.select4 = res.result[3];
                        that.select5 = res.result[4];
                        that.select6 = res.result[5];
                        that.select7 = res.result[6];
                    }
                }
            })
        }
    },
    mounted() {
        this.init();
    },
};
</script>

<style lang="less">
.search {
    .operation {
        margin-bottom: 2vh;
    }

    .select-count {
        font-weight: 600;
        color: #40a9ff;
    }

    .select-clear {
        margin-left: 10px;
    }

    .page {
        margin-top: 2vh;
    }

    .drop-down {
        margin-left: 5px;
    }
}

.filter-panel {
    width: 166px;
    min-height: 120px;
    height: 200px;
    position: absolute;
    background-color: white;
    z-index: 9999;
    margin-left: 1px;
    overflow-y: scroll;
    border: 1px solid blue;
    top: 35px;
    right: 10px;
}

.openSearch {
    position: absolute;
    right: 240px;
}

.openTip {
    position: absolute;
    right: 130px;
}

.showFilterPanelFlag {
    position: static !important;
    right: 10px;
    margin-right: 10px;
}

.ivu-table td {
    height: 38px !important;
}

.ivu-table-cell-with-expand {
    height: 38px !important;
    line-height: 38px !important;
}

.ivu-table .rowClassNmaeColor td {
    background-color: #b0b3b6 !important;
    color: #ffffff !important;
    font-size: 12px;
}
</style>
