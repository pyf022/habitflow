package com.habitflow.backend.domain.dto;

import java.util.List;

public record CoachRecommendationDto(
    String evidenceTag,
    String dataWindow,
    String summary,
    List<ActionButtonDto> actions,
    String closingHint
) {
}
