package com.habitflow.backend.domain.dto;

import java.util.List;

public record HabitInsightDto(
    String title,
    String evidenceLevel,
    String body,
    List<ActionButtonDto> actions
) {
}
