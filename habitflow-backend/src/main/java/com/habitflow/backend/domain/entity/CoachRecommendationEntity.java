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
@TableName(value = "coach_recommendation", autoResultMap = true)
public class CoachRecommendationEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    @TableField("evidence_tag")
    private String evidenceTag;

    @TableField("data_window")
    private String dataWindow;

    private String summary;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<ActionButtonPayload> actions;

    @TableField("closing_hint")
    private String closingHint;
}
