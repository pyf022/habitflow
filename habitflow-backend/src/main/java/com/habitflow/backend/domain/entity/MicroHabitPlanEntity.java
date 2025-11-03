package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.habitflow.backend.domain.payload.ActionButtonPayload;
import java.util.List;
import lombok.Data;

@Data
@TableName(value = "micro_habit_plan", autoResultMap = true)
public class MicroHabitPlanEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String title;

    private String summary;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> metadata;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<ActionButtonPayload> actions;
}
