package com.habitflow.backend.domain.dto;

import java.util.List;

public record TodayDashboardResponse(
    ScreenContextDto context,
    MicroHabitPlanDto plan,
    HabitInsightDto insight,
    List<HabitQuickActionDto> quickActions,
    List<CoachMessageDto> chatThread
) {
}
