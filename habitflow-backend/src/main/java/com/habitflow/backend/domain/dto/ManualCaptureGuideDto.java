package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.BadgeStyle;
import com.habitflow.backend.domain.enums.HabitButtonKind;

public record ManualCaptureGuideDto(
    String headline,
    String body,
    String buttonTitle,
    HabitButtonKind buttonKind,
    String badgeText,
    BadgeStyle badgeStyle
) {
}
