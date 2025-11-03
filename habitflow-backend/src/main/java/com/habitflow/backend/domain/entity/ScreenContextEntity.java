package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.habitflow.backend.domain.enums.BadgeStyle;
import lombok.Data;

@Data
@TableName("screen_context")
public class ScreenContextEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    /**
     * Screen identifier such as TODAY, COACH, LOG, WEEKLY, PROFILE.
     */
    @TableField("screen_code")
    private String screenCode;

    @TableField("status_bar_time")
    private String statusBarTime;

    @TableField("timestamp_label")
    private String timestampLabel;

    @TableField("title_text")
    private String titleText;

    @TableField("subtitle_text")
    private String subtitleText;

    @TableField("goal_chip")
    private String goalChip;

    @TableField("badge_text")
    private String badgeText;

    @TableField("badge_style")
    private BadgeStyle badgeStyle;
}
