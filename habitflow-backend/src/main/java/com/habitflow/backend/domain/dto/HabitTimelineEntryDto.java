package com.habitflow.backend.domain.dto;

public record HabitTimelineEntryDto(
    String time,
    String title,
    String meta,
    String detail
) {
}
