package com.habitflow.backend.domain.dto;

import java.util.List;

public record ProfileDataStrategyDto(
    String summary,
    List<ActionButtonDto> actions
) {
}
