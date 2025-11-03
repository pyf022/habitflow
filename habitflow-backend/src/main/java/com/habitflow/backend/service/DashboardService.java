package com.habitflow.backend.service;

import com.habitflow.backend.domain.dto.CoachDashboardResponse;
import com.habitflow.backend.domain.dto.LogDashboardResponse;
import com.habitflow.backend.domain.dto.ProfileDashboardResponse;
import com.habitflow.backend.domain.dto.TodayDashboardResponse;
import com.habitflow.backend.domain.dto.WeeklyDashboardResponse;

public interface DashboardService {

    TodayDashboardResponse getTodayDashboard(Long userId);

    CoachDashboardResponse getCoachDashboard(Long userId);

    LogDashboardResponse getLogDashboard(Long userId);

    WeeklyDashboardResponse getWeeklyDashboard(Long userId);

    ProfileDashboardResponse getProfileDashboard(Long userId);
}
