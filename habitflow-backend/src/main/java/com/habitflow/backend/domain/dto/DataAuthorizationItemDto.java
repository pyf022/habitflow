package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.HabitButtonKind;

public record DataAuthorizationItemDto(
    String scope,
    String status,
    String actionTitle,
    HabitButtonKind buttonKind
) {
}
