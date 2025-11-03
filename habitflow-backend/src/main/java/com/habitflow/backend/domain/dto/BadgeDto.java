package com.habitflow.backend.domain.dto;

import com.habitflow.backend.domain.enums.BadgeStyle;

public record BadgeDto(String text, BadgeStyle style) {
}
