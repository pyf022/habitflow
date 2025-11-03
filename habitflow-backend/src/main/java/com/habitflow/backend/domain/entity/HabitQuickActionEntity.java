package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("habit_quick_action")
public class HabitQuickActionEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String domain;

    private String title;

    private String caption;

    @TableField("order_index")
    private Integer orderIndex;
}
