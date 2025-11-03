package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.habitflow.backend.domain.enums.BadgeStyle;
import com.habitflow.backend.domain.enums.HabitButtonKind;
import lombok.Data;

@Data
@TableName("manual_capture_guide")
public class ManualCaptureGuideEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String headline;

    private String body;

    @TableField("button_title")
    private String buttonTitle;

    @TableField("button_kind")
    private HabitButtonKind buttonKind;

    @TableField("badge_text")
    private String badgeText;

    @TableField("badge_style")
    private BadgeStyle badgeStyle;
}
