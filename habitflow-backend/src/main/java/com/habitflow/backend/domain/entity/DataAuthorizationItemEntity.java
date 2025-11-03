package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.habitflow.backend.domain.enums.HabitButtonKind;
import lombok.Data;

@Data
@TableName("data_authorization_item")
public class DataAuthorizationItemEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String scope;

    private String status;

    @TableField("action_title")
    private String actionTitle;

    @TableField("button_kind")
    private HabitButtonKind buttonKind;

    @TableField("order_index")
    private Integer orderIndex;
}
