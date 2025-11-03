package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.HabitButtonKind;

public record CoachComposerDto(
    String prompt,
    String placeholder,
    String submitTitle,
    HabitButtonKind buttonKind
) {
}
