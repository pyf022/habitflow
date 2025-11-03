package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("habit_timeline_entry")
public class HabitTimelineEntryEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String time;

    private String title;

    private String meta;

    private String detail;

    @TableField("order_index")
    private Integer orderIndex;
}
