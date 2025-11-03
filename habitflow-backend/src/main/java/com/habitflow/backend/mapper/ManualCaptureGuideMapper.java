package com.habitflow.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.habitflow.backend.domain.entity.ManualCaptureGuideEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManualCaptureGuideMapper extends BaseMapper<ManualCaptureGuideEntity> {
}
