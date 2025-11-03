package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.CoachMessageRole;

public record CoachMessageDto(
    CoachMessageRole role,
    String text
) {
}
