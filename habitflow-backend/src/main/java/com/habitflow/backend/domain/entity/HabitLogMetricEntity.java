package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("habit_log_metric")
public class HabitLogMetricEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String label;

    private String value;

    private String detail;

    @TableField("order_index")
    private Integer orderIndex;
}
