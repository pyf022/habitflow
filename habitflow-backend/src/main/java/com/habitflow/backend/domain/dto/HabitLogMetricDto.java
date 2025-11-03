package com.habitflow.backend.domain.dto;

public record HabitLogMetricDto(
    String label,
    String value,
    String detail
) {
}
