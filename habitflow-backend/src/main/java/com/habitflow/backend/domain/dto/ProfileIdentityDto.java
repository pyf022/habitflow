package com.habitflow.backend.domain.dto;

public record ProfileIdentityDto(
    String initials,
    String displayName,
    String email,
    String lastSyncLabel,
    String experimentTag
) {
}
