package cn.zwz.stu.entity;

import cn.zwz.basics.baseClass.ZwzBaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "a_competition")
@TableName("a_competition")
@ApiModel(value = "学科竞赛")
public class Competition extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "评分ID")
    private String evaluateId;

    @ApiModelProperty(value = "竞赛级别")
    private String level;

    @ApiModelProperty(value = "竞赛名称")
    private String title;

    @ApiModelProperty(value = "竞赛奖项")
    private String value;
}