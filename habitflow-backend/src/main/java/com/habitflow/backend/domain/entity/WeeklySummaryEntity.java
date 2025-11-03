package com.habitflow.backend.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import java.util.List;
import lombok.Data;

@Data
@TableName(value = "weekly_summary", autoResultMap = true)
public class WeeklySummaryEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    @TableField("progress_ratio")
    private Double progressRatio;

    @TableField("trend_label")
    private String trendLabel;

    @TableField("trend_value")
    private String trendValue;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> summaryLines;
}
