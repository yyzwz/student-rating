<template>
<div class="search">
    <Card>
        <Divider>学业发展水平 - 自评问卷</Divider>
        <Form label-position="top">
            <Row :gitter="16">
                <Col span="24">
                <FormItem label="1. 有关心国家及世界大事，维护国家利益和国家形象的意识">
                    <Select v-model="select1" style="width:570px">
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
                <FormItem label="2. 热爱集体，积极参加集体活动">
                    <Select v-model="select2" style="width:570px">
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
                <FormItem label="3. 诚实守信 、为人正派，能分清善恶、是非">
                    <Select v-model="select3" style="width:570px">
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
                <FormItem label="4. 了解法律知识 ，具有民主和法制观念，能运用法律维护他人和自身利益">
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
                <FormItem label="5. 熟知并履行《 中小学生守则 》和《 中学生日常行为规范 》,满分20，自行填写">
                    <InputNumber :max="20" :min="0" v-model="select5" style="width:570px"></InputNumber>
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
    editPinDeZiPing
} from "./api.js";
export default {
    name: "single-window",
    components: {},
    data() {
        return {
            select1: "0",
            select2: "0",
            select3: "0",
            select4: "0",
            select5: 0
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
            sum += Number(that.select1) + Number(that.select2) + Number(that.select3) + Number(that.select4) + Number(that.select5);
            strAns += that.select1 + "," + that.select2 + "," + that.select3 + "," + that.select4 + "," + that.select5;
            saveOneByType({
                type: 2,
                value: strAns
            }).then(res => {
                if (res.success) {
                    this.$Message.success("问卷保存成功");
                }
            })
            editPinDeZiPing({
                grade: sum
            }).then(res => {
                if (res.success) {
                    this.$Message.success("更新总评价单成功");
                }
            })

        },
        resetForm() {
            this.select1 = "0";
            this.select2 = "0";
            this.select3 = "0";
            this.select4 = "0";
            this.select5 = 0;
        },
        getOneByTypeFx() {
            var that = this;
            getOneByType({
                type: 2
            }).then(res => {
                if (res.success) {
                    if (res.result.length > 0) {
                        that.select1 = res.result[0];
                        that.select2 = res.result[1];
                        that.select3 = res.result[2];
                        that.select4 = res.result[3];
                        that.select5 = res.result[4];
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
