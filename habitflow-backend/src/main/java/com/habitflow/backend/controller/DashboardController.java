package com.habitflow.backend.controller;

import com.habitflow.backend.domain.dto.*;
import com.habitflow.backend.service.DashboardService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
    public ResponseEntity<CoachDashboardResponse> getCoach(
            @RequestParam(name = "userId", required = false) Long userId) {

        CoachDashboardResponse result = dashboardService.getCoachDashboard(resolveUserId(userId));

        // 明确告诉Spring：即使是null，也应该返回200
        if (result == null) {
            return ResponseEntity.ok(new CoachDashboardResponse(
                    null,       // 可传空对象或 null
                    List.of(),                    // 空列表
                    null, // 或 null，看你的DTO定义
                    null));
        }

        return ResponseEntity.ok(result);
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
        //return userId != null ? userId : DEFAULT_USER_ID;
        return 123456789L;
    }
}
