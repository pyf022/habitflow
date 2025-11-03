package com.habitflow.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.habitflow.backend.domain.entity.HabitTimelineEntryEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HabitTimelineEntryMapper extends BaseMapper<HabitTimelineEntryEntity> {
}
