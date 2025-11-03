package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.HabitButtonKind;
import java.util.List;

public record WeeklyPlanItemDto(
    String title,
    List<PlanMetadataItemDto> metadata,
    String buttonTitle,
    HabitButtonKind buttonKind
) {
}
