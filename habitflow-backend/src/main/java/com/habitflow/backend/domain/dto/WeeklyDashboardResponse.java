package com.habitflow.backend.domain.dto;

import java.util.List;

public record WeeklyDashboardResponse(
    ScreenContextDto context,
    WeeklySummaryDto summary,
    List<WeeklyInsightDto> insights,
    List<WeeklyPlanItemDto> plan
) {
}
