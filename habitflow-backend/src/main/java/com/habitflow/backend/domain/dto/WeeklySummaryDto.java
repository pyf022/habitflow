package com.habitflow.backend.domain.dto;

import java.util.List;

public record WeeklySummaryDto(
    double progressRatio,
    String trendLabel,
    String trendValue,
    List<String> summaryLines
) {
}
