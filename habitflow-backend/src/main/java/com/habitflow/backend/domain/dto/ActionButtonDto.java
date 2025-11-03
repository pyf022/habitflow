package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.HabitButtonKind;

public record ActionButtonDto(String title, HabitButtonKind kind) {
}
