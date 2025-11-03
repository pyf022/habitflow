package com.habitflow.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.habitflow.backend.domain.entity.CoachMessageEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CoachMessageMapper extends BaseMapper<CoachMessageEntity> {
}
