package com.habitflow.backend.domain.dto;

import java.util.List;

public record LogDashboardResponse(
    ScreenContextDto context,
    List<HabitLogMetricDto> metrics,
    List<HabitTimelineEntryDto> timeline,
    ManualCaptureGuideDto manualCapture
) {
}
