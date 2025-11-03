package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.habitflow.backend.domain.enums.HabitButtonKind;
import com.habitflow.backend.domain.payload.PlanMetadataItemPayload;
import java.util.List;
import lombok.Data;

@Data
@TableName(value = "weekly_plan_item", autoResultMap = true)
public class WeeklyPlanItemEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String title;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<PlanMetadataItemPayload> metadata;

    @TableField("button_title")
    private String buttonTitle;

    @TableField("button_kind")
    private HabitButtonKind buttonKind;

    @TableField("order_index")
    private Integer orderIndex;
}
