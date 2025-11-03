package com.habitflow.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.habitflow.backend.domain.dto.ActionButtonDto;
import com.habitflow.backend.domain.dto.BadgeDto;
import com.habitflow.backend.domain.dto.CoachComposerDto;
import com.habitflow.backend.domain.dto.CoachDashboardResponse;
import com.habitflow.backend.domain.dto.CoachMessageDto;
import com.habitflow.backend.domain.dto.CoachRecommendationDto;
import com.habitflow.backend.domain.dto.DataAuthorizationItemDto;
import com.habitflow.backend.domain.dto.HabitInsightDto;
import com.habitflow.backend.domain.dto.HabitLogMetricDto;
import com.habitflow.backend.domain.dto.HabitQuickActionDto;
import com.habitflow.backend.domain.dto.HabitTimelineEntryDto;
import com.habitflow.backend.domain.dto.LogDashboardResponse;
import com.habitflow.backend.domain.dto.ManualCaptureGuideDto;
import com.habitflow.backend.domain.dto.MicroHabitPlanDto;
import com.habitflow.backend.domain.dto.PlanMetadataItemDto;
import com.habitflow.backend.domain.dto.ProfileDashboardResponse;
import com.habitflow.backend.domain.dto.ProfileDataStrategyDto;
import com.habitflow.backend.domain.dto.ProfileIdentityDto;
import com.habitflow.backend.domain.dto.ProfileLinkDto;
import com.habitflow.backend.domain.dto.ScreenContextDto;
import com.habitflow.backend.domain.dto.SettingPreferenceDto;
import com.habitflow.backend.domain.dto.TodayDashboardResponse;
import com.habitflow.backend.domain.dto.WeeklyDashboardResponse;
import com.habitflow.backend.domain.dto.WeeklyInsightDto;
import com.habitflow.backend.domain.dto.WeeklyPlanItemDto;
import com.habitflow.backend.domain.dto.WeeklySummaryDto;
import com.habitflow.backend.domain.entity.CoachComposerGuideEntity;
import com.habitflow.backend.domain.entity.CoachMessageEntity;
import com.habitflow.backend.domain.entity.CoachRecommendationEntity;
import com.habitflow.backend.domain.entity.DataAuthorizationItemEntity;
import com.habitflow.backend.domain.entity.HabitInsightEntity;
import com.habitflow.backend.domain.entity.HabitLogMetricEntity;
import com.habitflow.backend.domain.entity.HabitQuickActionEntity;
import com.habitflow.backend.domain.entity.HabitTimelineEntryEntity;
import com.habitflow.backend.domain.entity.ManualCaptureGuideEntity;
import com.habitflow.backend.domain.entity.MicroHabitPlanEntity;
import com.habitflow.backend.domain.entity.ProfileDataStrategyEntity;
import com.habitflow.backend.domain.entity.ProfileIdentityEntity;
import com.habitflow.backend.domain.entity.ProfileLinkEntity;
import com.habitflow.backend.domain.entity.ScreenContextEntity;
import com.habitflow.backend.domain.entity.SettingPreferenceEntity;
import com.habitflow.backend.domain.entity.WeeklyInsightEntity;
import com.habitflow.backend.domain.entity.WeeklyPlanItemEntity;
import com.habitflow.backend.domain.entity.WeeklySummaryEntity;
import com.habitflow.backend.domain.payload.ActionButtonPayload;
import com.habitflow.backend.domain.payload.PlanMetadataItemPayload;
import com.habitflow.backend.mapper.CoachComposerGuideMapper;
import com.habitflow.backend.mapper.CoachMessageMapper;
import com.habitflow.backend.mapper.CoachRecommendationMapper;
import com.habitflow.backend.mapper.DataAuthorizationItemMapper;
import com.habitflow.backend.mapper.HabitInsightMapper;
import com.habitflow.backend.mapper.HabitLogMetricMapper;
import com.habitflow.backend.mapper.HabitQuickActionMapper;
import com.habitflow.backend.mapper.HabitTimelineEntryMapper;
import com.habitflow.backend.mapper.ManualCaptureGuideMapper;
import com.habitflow.backend.mapper.MicroHabitPlanMapper;
import com.habitflow.backend.mapper.ProfileDataStrategyMapper;
import com.habitflow.backend.mapper.ProfileIdentityMapper;
import com.habitflow.backend.mapper.ProfileLinkMapper;
import com.habitflow.backend.mapper.ScreenContextMapper;
import com.habitflow.backend.mapper.SettingPreferenceMapper;
import com.habitflow.backend.mapper.WeeklyInsightMapper;
import com.habitflow.backend.mapper.WeeklyPlanItemMapper;
import com.habitflow.backend.mapper.WeeklySummaryMapper;
import com.habitflow.backend.service.DashboardService;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class DashboardServiceImpl implements DashboardService {

    private static final String SCREEN_TODAY = "TODAY";
    private static final String SCREEN_COACH = "COACH";
    private static final String SCREEN_LOG = "LOG";
    private static final String SCREEN_WEEKLY = "WEEKLY";
    private static final String SCREEN_PROFILE = "PROFILE";

    private final ScreenContextMapper screenContextMapper;
    private final MicroHabitPlanMapper microHabitPlanMapper;
    private final HabitInsightMapper habitInsightMapper;
    private final HabitQuickActionMapper habitQuickActionMapper;
    private final CoachMessageMapper coachMessageMapper;
    private final CoachRecommendationMapper coachRecommendationMapper;
    private final HabitLogMetricMapper habitLogMetricMapper;
    private final HabitTimelineEntryMapper habitTimelineEntryMapper;
    private final WeeklyInsightMapper weeklyInsightMapper;
    private final WeeklyPlanItemMapper weeklyPlanItemMapper;
    private final WeeklySummaryMapper weeklySummaryMapper;
    private final ManualCaptureGuideMapper manualCaptureGuideMapper;
    private final CoachComposerGuideMapper coachComposerGuideMapper;
    private final DataAuthorizationItemMapper dataAuthorizationItemMapper;
    private final SettingPreferenceMapper settingPreferenceMapper;
    private final ProfileLinkMapper profileLinkMapper;
    private final ProfileIdentityMapper profileIdentityMapper;
    private final ProfileDataStrategyMapper profileDataStrategyMapper;

    public DashboardServiceImpl(
        ScreenContextMapper screenContextMapper,
        MicroHabitPlanMapper microHabitPlanMapper,
        HabitInsightMapper habitInsightMapper,
        HabitQuickActionMapper habitQuickActionMapper,
        CoachMessageMapper coachMessageMapper,
        CoachRecommendationMapper coachRecommendationMapper,
        HabitLogMetricMapper habitLogMetricMapper,
        HabitTimelineEntryMapper habitTimelineEntryMapper,
        WeeklyInsightMapper weeklyInsightMapper,
        WeeklyPlanItemMapper weeklyPlanItemMapper,
        WeeklySummaryMapper weeklySummaryMapper,
        ManualCaptureGuideMapper manualCaptureGuideMapper,
        CoachComposerGuideMapper coachComposerGuideMapper,
        DataAuthorizationItemMapper dataAuthorizationItemMapper,
        SettingPreferenceMapper settingPreferenceMapper,
        ProfileLinkMapper profileLinkMapper,
        ProfileIdentityMapper profileIdentityMapper,
        ProfileDataStrategyMapper profileDataStrategyMapper) {
        this.screenContextMapper = screenContextMapper;
        this.microHabitPlanMapper = microHabitPlanMapper;
        this.habitInsightMapper = habitInsightMapper;
        this.habitQuickActionMapper = habitQuickActionMapper;
        this.coachMessageMapper = coachMessageMapper;
        this.coachRecommendationMapper = coachRecommendationMapper;
        this.habitLogMetricMapper = habitLogMetricMapper;
        this.habitTimelineEntryMapper = habitTimelineEntryMapper;
        this.weeklyInsightMapper = weeklyInsightMapper;
        this.weeklyPlanItemMapper = weeklyPlanItemMapper;
        this.weeklySummaryMapper = weeklySummaryMapper;
        this.manualCaptureGuideMapper = manualCaptureGuideMapper;
        this.coachComposerGuideMapper = coachComposerGuideMapper;
        this.dataAuthorizationItemMapper = dataAuthorizationItemMapper;
        this.settingPreferenceMapper = settingPreferenceMapper;
        this.profileLinkMapper = profileLinkMapper;
        this.profileIdentityMapper = profileIdentityMapper;
        this.profileDataStrategyMapper = profileDataStrategyMapper;
    }

    @Override
    @Cacheable(value = "todayDashboard", key = "#userId")
    public TodayDashboardResponse getTodayDashboard(Long userId) {
        ScreenContextDto context = mapContext(fetchContext(userId, SCREEN_TODAY));
        MicroHabitPlanDto plan = mapPlan(fetchPlan(userId));
        HabitInsightDto insight = mapInsight(fetchInsight(userId));
        List<HabitQuickActionDto> quickActions = habitQuickActionMapper.selectList(
                new LambdaQueryWrapper<HabitQuickActionEntity>()
                    .eq(HabitQuickActionEntity::getUserId, userId)
                    .orderByAsc(HabitQuickActionEntity::getOrderIndex))
            .stream()
            .map(this::mapQuickAction)
            .toList();
        List<CoachMessageDto> thread = coachMessageMapper.selectList(
                new LambdaQueryWrapper<CoachMessageEntity>()
                    .eq(CoachMessageEntity::getUserId, userId)
                    .orderByAsc(CoachMessageEntity::getOrderIndex))
            .stream()
            .map(this::mapCoachMessage)
            .toList();

        return new TodayDashboardResponse(context, plan, insight, quickActions, thread);
    }

    @Override
    @Cacheable(value = "coachDashboard", key = "#userId")
    public CoachDashboardResponse getCoachDashboard(Long userId) {
        ScreenContextDto context = mapContext(fetchContext(userId, SCREEN_COACH));

        List<CoachMessageDto> thread = coachMessageMapper.selectList(
                new LambdaQueryWrapper<CoachMessageEntity>()
                    .eq(CoachMessageEntity::getUserId, userId)
                    .orderByAsc(CoachMessageEntity::getOrderIndex))
            .stream()
            .map(this::mapCoachMessage)
            .toList();

        CoachRecommendationDto recommendation = mapCoachRecommendation(fetchCoachRecommendation(userId));
        CoachComposerDto composer = mapCoachComposer(fetchComposerGuide(userId));

        return new CoachDashboardResponse(context, thread, recommendation, composer);
    }

    @Override
    @Cacheable(value = "logDashboard", key = "#userId")
    public LogDashboardResponse getLogDashboard(Long userId) {
        ScreenContextDto context = mapContext(fetchContext(userId, SCREEN_LOG));

        List<HabitLogMetricDto> metrics = habitLogMetricMapper.selectList(
                new LambdaQueryWrapper<HabitLogMetricEntity>()
                    .eq(HabitLogMetricEntity::getUserId, userId)
                    .orderByAsc(HabitLogMetricEntity::getOrderIndex))
            .stream()
            .map(this::mapMetric)
            .toList();

        List<HabitTimelineEntryDto> timeline = habitTimelineEntryMapper.selectList(
                new LambdaQueryWrapper<HabitTimelineEntryEntity>()
                    .eq(HabitTimelineEntryEntity::getUserId, userId)
                    .orderByAsc(HabitTimelineEntryEntity::getOrderIndex))
            .stream()
            .map(this::mapTimelineEntry)
            .toList();

        ManualCaptureGuideDto manualCapture = mapManualCapture(fetchManualCaptureGuide(userId));

        return new LogDashboardResponse(context, metrics, timeline, manualCapture);
    }

    @Override
    @Cacheable(value = "weeklyDashboard", key = "#userId")
    public WeeklyDashboardResponse getWeeklyDashboard(Long userId) {
        ScreenContextDto context = mapContext(fetchContext(userId, SCREEN_WEEKLY));
        WeeklySummaryDto summary = mapWeeklySummary(fetchWeeklySummary(userId));

        List<WeeklyInsightDto> insights = weeklyInsightMapper.selectList(
                new LambdaQueryWrapper<WeeklyInsightEntity>()
                    .eq(WeeklyInsightEntity::getUserId, userId)
                    .orderByAsc(WeeklyInsightEntity::getOrderIndex))
            .stream()
            .map(this::mapWeeklyInsight)
            .toList();

        List<WeeklyPlanItemDto> plan = weeklyPlanItemMapper.selectList(
                new LambdaQueryWrapper<WeeklyPlanItemEntity>()
                    .eq(WeeklyPlanItemEntity::getUserId, userId)
                    .orderByAsc(WeeklyPlanItemEntity::getOrderIndex))
            .stream()
            .map(this::mapWeeklyPlanItem)
            .toList();

        return new WeeklyDashboardResponse(context, summary, insights, plan);
    }

    @Override
    @Cacheable(value = "profileDashboard", key = "#userId")
    public ProfileDashboardResponse getProfileDashboard(Long userId) {
        ScreenContextDto context = mapContext(fetchContext(userId, SCREEN_PROFILE));
        ProfileIdentityDto identity = mapProfileIdentity(fetchProfileIdentity(userId));
        ProfileDataStrategyDto dataStrategy = mapProfileDataStrategy(fetchProfileDataStrategy(userId));

        List<SettingPreferenceDto> settings = settingPreferenceMapper.selectList(
                new LambdaQueryWrapper<SettingPreferenceEntity>()
                    .eq(SettingPreferenceEntity::getUserId, userId)
                    .orderByAsc(SettingPreferenceEntity::getOrderIndex))
            .stream()
            .map(this::mapSettingPreference)
            .toList();

        List<ProfileLinkDto> links = profileLinkMapper.selectList(
                new LambdaQueryWrapper<ProfileLinkEntity>()
                    .eq(ProfileLinkEntity::getUserId, userId)
                    .orderByAsc(ProfileLinkEntity::getOrderIndex))
            .stream()
            .map(this::mapProfileLink)
            .toList();

        List<DataAuthorizationItemDto> dataAuthorizations = dataAuthorizationItemMapper.selectList(
                new LambdaQueryWrapper<DataAuthorizationItemEntity>()
                    .eq(DataAuthorizationItemEntity::getUserId, userId)
                    .orderByAsc(DataAuthorizationItemEntity::getOrderIndex))
            .stream()
            .map(this::mapDataAuthorization)
            .toList();

        return new ProfileDashboardResponse(context, identity, dataStrategy, settings, links, dataAuthorizations);
    }

    private ScreenContextEntity fetchContext(Long userId, String screenCode) {
        return Optional.ofNullable(
            screenContextMapper.selectOne(
                new LambdaQueryWrapper<ScreenContextEntity>()
                    .eq(ScreenContextEntity::getUserId, userId)
                    .eq(ScreenContextEntity::getScreenCode, screenCode)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Screen context", screenCode));
    }

    private MicroHabitPlanEntity fetchPlan(Long userId) {
        return Optional.ofNullable(
            microHabitPlanMapper.selectOne(
                new LambdaQueryWrapper<MicroHabitPlanEntity>()
                    .eq(MicroHabitPlanEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Micro habit plan", userId));
    }

    private HabitInsightEntity fetchInsight(Long userId) {
        return Optional.ofNullable(
            habitInsightMapper.selectOne(
                new LambdaQueryWrapper<HabitInsightEntity>()
                    .eq(HabitInsightEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Habit insight", userId));
    }

    private CoachRecommendationEntity fetchCoachRecommendation(Long userId) {
        return Optional.ofNullable(
            coachRecommendationMapper.selectOne(
                new LambdaQueryWrapper<CoachRecommendationEntity>()
                    .eq(CoachRecommendationEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Coach recommendation", userId));
    }

    private ManualCaptureGuideEntity fetchManualCaptureGuide(Long userId) {
        return Optional.ofNullable(
            manualCaptureGuideMapper.selectOne(
                new LambdaQueryWrapper<ManualCaptureGuideEntity>()
                    .eq(ManualCaptureGuideEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Manual capture guide", userId));
    }

    private WeeklySummaryEntity fetchWeeklySummary(Long userId) {
        return Optional.ofNullable(
            weeklySummaryMapper.selectOne(
                new LambdaQueryWrapper<WeeklySummaryEntity>()
                    .eq(WeeklySummaryEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Weekly summary", userId));
    }

    private CoachComposerGuideEntity fetchComposerGuide(Long userId) {
        return Optional.ofNullable(
            coachComposerGuideMapper.selectOne(
                new LambdaQueryWrapper<CoachComposerGuideEntity>()
                    .eq(CoachComposerGuideEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Coach composer guide", userId));
    }

    private ProfileIdentityEntity fetchProfileIdentity(Long userId) {
        return Optional.ofNullable(
            profileIdentityMapper.selectOne(
                new LambdaQueryWrapper<ProfileIdentityEntity>()
                    .eq(ProfileIdentityEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Profile identity", userId));
    }

    private ProfileDataStrategyEntity fetchProfileDataStrategy(Long userId) {
        return Optional.ofNullable(
            profileDataStrategyMapper.selectOne(
                new LambdaQueryWrapper<ProfileDataStrategyEntity>()
                    .eq(ProfileDataStrategyEntity::getUserId, userId)
                    .last("limit 1")))
            .orElseThrow(() -> notFound("Profile data strategy", userId));
    }

    private ScreenContextDto mapContext(ScreenContextEntity entity) {
        return new ScreenContextDto(
            entity.getStatusBarTime(),
            entity.getTimestampLabel(),
            entity.getTitleText(),
            entity.getSubtitleText(),
            entity.getGoalChip(),
            new BadgeDto(entity.getBadgeText(), entity.getBadgeStyle())
        );
    }

    private MicroHabitPlanDto mapPlan(MicroHabitPlanEntity entity) {
        return new MicroHabitPlanDto(
            entity.getTitle(),
            entity.getSummary(),
            Optional.ofNullable(entity.getMetadata()).orElse(List.of()),
            mapActionList(entity.getActions())
        );
    }

    private HabitInsightDto mapInsight(HabitInsightEntity entity) {
        return new HabitInsightDto(
            entity.getTitle(),
            entity.getEvidenceLevel(),
            entity.getBody(),
            mapActionList(entity.getActions())
        );
    }

    private HabitQuickActionDto mapQuickAction(HabitQuickActionEntity entity) {
        return new HabitQuickActionDto(
            entity.getDomain(),
            entity.getTitle(),
            entity.getCaption()
        );
    }

    private CoachMessageDto mapCoachMessage(CoachMessageEntity entity) {
        return new CoachMessageDto(entity.getRole(), entity.getText());
    }

    private CoachRecommendationDto mapCoachRecommendation(CoachRecommendationEntity entity) {
        return new CoachRecommendationDto(
            entity.getEvidenceTag(),
            entity.getDataWindow(),
            entity.getSummary(),
            mapActionList(entity.getActions()),
            entity.getClosingHint()
        );
    }

    private CoachComposerDto mapCoachComposer(CoachComposerGuideEntity entity) {
        return new CoachComposerDto(
            entity.getPrompt(),
            entity.getPlaceholder(),
            entity.getSubmitTitle(),
            entity.getButtonKind()
        );
    }

    private HabitLogMetricDto mapMetric(HabitLogMetricEntity entity) {
        return new HabitLogMetricDto(entity.getLabel(), entity.getValue(), entity.getDetail());
    }

    private HabitTimelineEntryDto mapTimelineEntry(HabitTimelineEntryEntity entity) {
        return new HabitTimelineEntryDto(
            entity.getTime(),
            entity.getTitle(),
            entity.getMeta(),
            entity.getDetail()
        );
    }

    private ManualCaptureGuideDto mapManualCapture(ManualCaptureGuideEntity entity) {
        return new ManualCaptureGuideDto(
            entity.getHeadline(),
            entity.getBody(),
            entity.getButtonTitle(),
            entity.getButtonKind(),
            entity.getBadgeText(),
            entity.getBadgeStyle()
        );
    }

    private WeeklySummaryDto mapWeeklySummary(WeeklySummaryEntity entity) {
        return new WeeklySummaryDto(
            Optional.ofNullable(entity.getProgressRatio()).orElse(0.0),
            entity.getTrendLabel(),
            entity.getTrendValue(),
            Optional.ofNullable(entity.getSummaryLines()).orElse(List.of())
        );
    }

    private WeeklyInsightDto mapWeeklyInsight(WeeklyInsightEntity entity) {
        return new WeeklyInsightDto(
            entity.getTitle(),
            entity.getDetail(),
            entity.getCta()
        );
    }

    private WeeklyPlanItemDto mapWeeklyPlanItem(WeeklyPlanItemEntity entity) {
        return new WeeklyPlanItemDto(
            entity.getTitle(),
            Optional.ofNullable(entity.getMetadata()).orElse(List.of())
                .stream()
                .map(this::mapMetadataItem)
                .collect(Collectors.toList()),
            entity.getButtonTitle(),
            entity.getButtonKind()
        );
    }

    private PlanMetadataItemDto mapMetadataItem(PlanMetadataItemPayload payload) {
        return new PlanMetadataItemDto(payload.getLabel(), payload.getValue());
    }

    private DataAuthorizationItemDto mapDataAuthorization(DataAuthorizationItemEntity entity) {
        return new DataAuthorizationItemDto(
            entity.getScope(),
            entity.getStatus(),
            entity.getActionTitle(),
            entity.getButtonKind()
        );
    }

    private SettingPreferenceDto mapSettingPreference(SettingPreferenceEntity entity) {
        return new SettingPreferenceDto(entity.getTitle(), Boolean.TRUE.equals(entity.getEnabled()));
    }

    private ProfileLinkDto mapProfileLink(ProfileLinkEntity entity) {
        return new ProfileLinkDto(entity.getTitle(), entity.getIcon());
    }

    private ProfileIdentityDto mapProfileIdentity(ProfileIdentityEntity entity) {
        return new ProfileIdentityDto(
            entity.getInitials(),
            entity.getDisplayName(),
            entity.getEmail(),
            entity.getLastSyncLabel(),
            entity.getExperimentTag()
        );
    }

    private ProfileDataStrategyDto mapProfileDataStrategy(ProfileDataStrategyEntity entity) {
        return new ProfileDataStrategyDto(
            entity.getSummary(),
            mapActionList(entity.getActions())
        );
    }

    private List<ActionButtonDto> mapActionList(List<ActionButtonPayload> actions) {
        return Optional.ofNullable(actions).orElse(List.of())
            .stream()
            .filter(Objects::nonNull)
            .map(action -> new ActionButtonDto(action.getTitle(), action.getKind()))
            .toList();
    }

    private ResponseStatusException notFound(String resource, Object reference) {
        return new ResponseStatusException(
            HttpStatus.NOT_FOUND,
            "%s not found for reference %s".formatted(resource, reference)
        );
    }
}
