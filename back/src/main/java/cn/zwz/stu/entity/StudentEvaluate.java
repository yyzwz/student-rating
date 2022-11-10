package cn.zwz.stu.entity;

import cn.zwz.basics.baseClass.ZwzBaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.math.BigDecimal;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "a_student_evaluate")
@TableName("a_student_evaluate")
@ApiModel(value = "学生评价")
public class StudentEvaluate extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户ID")
    private String userId;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "学生姓名")
    private String userName;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "学生班级")
    private String userClass;

    /**
     * 学业发展水平
     */

    @ApiModelProperty(value = "语文成绩")
    private BigDecimal achievementOne;

    @ApiModelProperty(value = "数学成绩")
    private BigDecimal achievementTwo;

    @ApiModelProperty(value = "外语成绩")
    private BigDecimal achievementThree;

    @ApiModelProperty(value = "成绩平均")
    private BigDecimal achievementSum;

    @ApiModelProperty(value = "自评问卷分值")
    private BigDecimal questionnaireOne;

    @ApiModelProperty(value = "获奖加分")
    private BigDecimal competitionMine;

    @ApiModelProperty(value = "学业发展水平得分")
    private BigDecimal ansOne;

    /**
     * 品德与社会化水平
     */

    @ApiModelProperty(value = "自评问卷分值")
    private BigDecimal questionnaireTwo;

    @ApiModelProperty(value = "教师问卷分值")
    private BigDecimal questionnaireThree;

    @ApiModelProperty(value = "品德与社会化水平得分")
    private BigDecimal ansTwo;

    /**
     * 身心健康水平
     */

    @ApiModelProperty(value = "自评问卷分值")
    private BigDecimal questionnaireFour;

    @ApiModelProperty(value = "教师问卷分值")
    private BigDecimal questionnaireSix;

    @ApiModelProperty(value = "教务处体育成绩")
    private BigDecimal questionnaireSeven;

    @ApiModelProperty(value = "身心健康得分")
    private BigDecimal ansThree;

    /**
     * 最终得分
     */

    @ApiModelProperty(value = "品德与社会化水平得分")
    private BigDecimal ansSum;
}