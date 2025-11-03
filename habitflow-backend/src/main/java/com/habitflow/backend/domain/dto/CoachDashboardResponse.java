package com.habitflow.backend.domain.dto;

import java.util.List;

public record CoachDashboardResponse(
    ScreenContextDto context,
    List<CoachMessageDto> thread,
    CoachRecommendationDto recommendation,
    CoachComposerDto composer
) {
}
