package com.habitflow.backend.controller;

import com.habitflow.backend.domain.dto.CoachDashboardResponse;
import com.habitflow.backend.domain.dto.LogDashboardResponse;
import com.habitflow.backend.domain.dto.TodayDashboardResponse;
import com.habitflow.backend.domain.dto.WeeklyDashboardResponse;
import com.habitflow.backend.service.DashboardService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/dashboard")
public class DashboardController {

    private static final Long DEFAULT_USER_ID = 1L;

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/today")
    public TodayDashboardResponse getToday(@RequestParam(name = "userId", required = false) Long userId) {
        return dashboardService.getTodayDashboard(resolveUserId(userId));
    }

    @GetMapping("/coach")
    public CoachDashboardResponse getCoach(@RequestParam(name = "userId", required = false) Long userId) {
        return dashboardService.getCoachDashboard(resolveUserId(userId));
    }

    @GetMapping("/log")
    public LogDashboardResponse getLog(@RequestParam(name = "userId", required = false) Long userId) {
        return dashboardService.getLogDashboard(resolveUserId(userId));
    }

    @GetMapping("/weekly")
    public WeeklyDashboardResponse getWeekly(@RequestParam(name = "userId", required = false) Long userId) {
        return dashboardService.getWeeklyDashboard(resolveUserId(userId));
    }

    private Long resolveUserId(Long userId) {
        return userId != null ? userId : DEFAULT_USER_ID;
    }
}
