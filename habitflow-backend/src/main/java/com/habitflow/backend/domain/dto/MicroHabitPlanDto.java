package com.habitflow.backend.domain.dto;

import java.util.List;

public record MicroHabitPlanDto(
    String title,
    String summary,
    List<String> metadata,
    List<ActionButtonDto> actions
) {
}
