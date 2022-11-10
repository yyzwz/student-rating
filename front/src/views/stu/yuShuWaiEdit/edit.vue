<template>
<div>
    <Card>
        <div slot="title">
            <div class="edit-head">
                <a @click="close" class="back-title">
                    <Icon type="ios-arrow-back" />返回
                </a>
                <div class="head-name">编辑</div>
                <span></span>
                <a @click="close" class="window-close">
                    <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
                </a>
            </div>
        </div>
        <Form ref="form" :model="form" :label-width="100" :rules="formValidate" label-position="left">
            <FormItem label="学生姓名" prop="userId">
                <Input v-model="form.userName" readonly style="width:570px" />
            </FormItem>
            <FormItem label="学生班级" prop="userId">
                <Input v-model="form.userClass" readonly style="width:570px" />
            </FormItem>
            <FormItem label="语文成绩" prop="achievementOne">
                <InputNumber v-model="form.achievementOne" min="0" max="100" style="width:570px"></InputNumber>
            </FormItem>
            <FormItem label="数学成绩" prop="achievementTwo">
                <InputNumber v-model="form.achievementTwo" min="0" max="100" style="width:570px"></InputNumber>
            </FormItem>
            <FormItem label="外语成绩" prop="achievementThree">
                <InputNumber v-model="form.achievementThree" min="0" max="100" style="width:570px"></InputNumber>
            </FormItem>
            <Form-item class="br">
                <Button @click="handleSubmit" :loading="submitLoading" type="primary">提交并保存</Button>
                <Button @click="handleReset">重置</Button>
                <Button type="dashed" @click="close">关闭</Button>
            </Form-item>
        </Form>
    </Card>
</div>
</template>

<script>
import {
    editStudentEvaluate,
    editYuShuWai
} from "./api.js";
export default {
    name: "edit",
    components: {},
    props: {
        data: Object
    },
    data() {
        return {
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
            this.handleReset();
            this.form = this.data;
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
