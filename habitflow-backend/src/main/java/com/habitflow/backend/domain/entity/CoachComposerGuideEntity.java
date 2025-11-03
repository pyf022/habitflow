package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.habitflow.backend.domain.enums.HabitButtonKind;
import lombok.Data;

@Data
@TableName("coach_composer_guide")
public class CoachComposerGuideEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String prompt;

    private String placeholder;

    @TableField("submit_title")
    private String submitTitle;

    @TableField("button_kind")
    private HabitButtonKind buttonKind;
}
