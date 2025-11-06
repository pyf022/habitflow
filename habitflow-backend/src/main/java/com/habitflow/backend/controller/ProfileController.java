package com.habitflow.backend.controller;

import com.habitflow.backend.domain.dto.ProfileDashboardResponse;
import com.habitflow.backend.service.DashboardService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/profile")
public class ProfileController {

    private static final Long DEFAULT_USER_ID = 1L;

    private final DashboardService dashboardService;

    public ProfileController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping
    public ProfileDashboardResponse getProfile(@RequestParam(name = "userId", required = false) Long userId) {
        return dashboardService.getProfileDashboard(resolveUserId(userId));
    }

    private Long resolveUserId(Long userId) {
        return userId != null ? userId : DEFAULT_USER_ID;
    }
}
