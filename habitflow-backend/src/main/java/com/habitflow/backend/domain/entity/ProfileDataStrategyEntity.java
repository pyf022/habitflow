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
@TableName(value = "profile_data_strategy", autoResultMap = true)
public class ProfileDataStrategyEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String summary;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<ActionButtonPayload> actions;
}
