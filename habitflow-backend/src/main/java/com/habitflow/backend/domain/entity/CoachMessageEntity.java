package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.habitflow.backend.domain.enums.CoachMessageRole;
import lombok.Data;

@Data
@TableName("coach_message")
public class CoachMessageEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private CoachMessageRole role;

    private String text;

    @TableField("order_index")
    private Integer orderIndex;
}
