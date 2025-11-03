package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("profile_link")
public class ProfileLinkEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String title;

    private String icon;

    @TableField("order_index")
    private Integer orderIndex;
}
