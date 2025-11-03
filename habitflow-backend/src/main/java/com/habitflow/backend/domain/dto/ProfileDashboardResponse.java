package com.habitflow.backend.domain.dto;

import java.util.List;

public record ProfileDashboardResponse(
    ScreenContextDto context,
    ProfileIdentityDto identity,
    ProfileDataStrategyDto dataStrategy,
    List<SettingPreferenceDto> settings,
    List<ProfileLinkDto> links,
    List<DataAuthorizationItemDto> dataAuthorizations
) {
}
