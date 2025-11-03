package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("profile_identity")
public class ProfileIdentityEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String initials;

    @TableField("display_name")
    private String displayName;

    private String email;

    @TableField("last_sync_label")
    private String lastSyncLabel;

    @TableField("experiment_tag")
    private String experimentTag;
}
