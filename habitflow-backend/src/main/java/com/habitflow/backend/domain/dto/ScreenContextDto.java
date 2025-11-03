package com.habitflow.backend.domain.dto;

public record ScreenContextDto(
    String statusBarTime,
    String timestampLabel,
    String titleText,
    String subtitleText,
    String goalChip,
    BadgeDto badge
) {
}
