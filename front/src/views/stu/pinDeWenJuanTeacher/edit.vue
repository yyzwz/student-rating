<template>
<div>
    <Card>
        <div slot="title">
            <div class="edit-head">
                <a @click="close" class="back-title">
                    <Icon type="ios-arrow-back" />返回
                </a>
                <div class="head-name">品德问卷</div>
                <span></span>
                <a @click="close" class="window-close">
                    <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
                </a>
            </div>
        </div>
        <Card>
            <Divider>品德发展水平 - 教评问卷</Divider>
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
    </Card>
</div>
</template>

<script>
import {
    saveOneByType,
    editYuShuWai,
    getOneByType,
    editPinDeTaPing
} from "./api.js";
export default {
    name: "edit",
    components: {},
    props: {
        data: Object
    },
    data() {
        return {
            select1: "0",
            select2: "0",
            select3: "0",
            select4: "0",
            select5: 0,
            submitLoading: false,
            form: {
                userId: "",
                achievementOne: 0,
                achievementTwo: 0,
                achievementThree: 0,
                achievementSum: 0,
            },
            formValidate: {}
        };
    },
    methods: {
        init() {
            this.resetForm();
            this.getOneByTypeFx();
            this.form = this.data;
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
                type: 3,
                value: strAns
            }).then(res => {
                if (res.success) {
                    this.$Message.success("问卷保存成功");
                }
            })
            editPinDeTaPing({
                id: that.form.id,
                grade: sum
            }).then(res => {
                if (res.success) {
                    that.submited();
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
                type: 3
            }).then(res => {
                console.log(res);
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
        },
        handleReset() {
            this.$refs.form.resetFields();
        },
        handleSubmit() {
            var that = this;
            that.submitLoading = true;
            editYuShuWai({
                id: that.form.id,
                yu: that.form.achievementOne,
                shu: that.form.achievementTwo,
                wai: that.form.achievementThree
            }).then(res => {
                that.submitLoading = false;
                if (res.success) {
                    this.$Message.success("保存成功");
                    that.submited();
                }
            })
        },
        close() {
            this.$emit("close", true);
        },
        submited() {
            this.$emit("submited", true);
        }
    },
    mounted() {
        this.init();
    }
};
</script>

<style lang="less">
.edit-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;

    .back-title {
        color: #515a6e;
        display: flex;
        align-items: center;
    }

    .head-name {
        display: inline-block;
        height: 20px;
        line-height: 20px;
        font-size: 16px;
        color: #17233d;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .window-close {
        z-index: 1;
        font-size: 12px;
        position: absolute;
        right: 0px;
        top: -5px;
        overflow: hidden;
        cursor: pointer;

        .ivu-icon-ios-close {
            color: #999;
            transition: color .2s ease;
        }
    }

    .window-close .ivu-icon-ios-close:hover {
        color: #444;
    }
}
</style>
