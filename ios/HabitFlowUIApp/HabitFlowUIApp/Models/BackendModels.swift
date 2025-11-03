import Foundation

enum BadgeStyleResponse: String, Codable {
    case primary = "PRIMARY"
    case outline = "OUTLINE"
    case warning = "WARNING"
}

enum ButtonKindResponse: String, Codable {
    case primary = "PRIMARY"
    case ghost = "GHOST"
    case tertiary = "TERTIARY"
    case link = "LINK"
}

enum CoachRoleResponse: String, Codable {
    case user = "USER"
    case ai = "AI"
}

struct BadgeResponse: Codable {
    let text: String
    let style: BadgeStyleResponse
}

struct ScreenContextResponse: Codable {
    let statusBarTime: String
    let timestampLabel: String
    let titleText: String
    let subtitleText: String?
    let goalChip: String?
    let badge: BadgeResponse?
}

struct ActionButtonResponse: Codable {
    let title: String
    let kind: ButtonKindResponse
}

struct MicroHabitPlanResponse: Codable {
    let title: String
    let summary: String
    let metadata: [String]?
    let actions: [ActionButtonResponse]?
}

struct HabitInsightResponse: Codable {
    let title: String
    let evidenceLevel: String
    let body: String
    let actions: [ActionButtonResponse]?
}

struct HabitQuickActionResponse: Codable, Identifiable {
    let id = UUID()
    let domain: String
    let title: String
    let caption: String
}

struct CoachMessageResponse: Codable, Identifiable {
    let id = UUID()
    let role: CoachRoleResponse
    let text: String
}

struct CoachRecommendationResponse: Codable {
    let evidenceTag: String
    let dataWindow: String
    let summary: String
    let actions: [ActionButtonResponse]?
    let closingHint: String?
}

struct CoachComposerResponse: Codable {
    let prompt: String
    let placeholder: String
    let submitTitle: String
    let buttonKind: ButtonKindResponse
}

struct HabitLogMetricResponse: Codable, Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let detail: String
}

struct HabitTimelineEntryResponse: Codable, Identifiable {
    let id = UUID()
    let time: String
    let title: String
    let meta: String
    let detail: String
}

struct ManualCaptureGuideResponse: Codable {
    let headline: String
    let body: String
    let buttonTitle: String
    let buttonKind: ButtonKindResponse
    let badgeText: String
    let badgeStyle: BadgeStyleResponse
}

struct WeeklySummaryResponse: Codable {
    let progressRatio: Double
    let trendLabel: String
    let trendValue: String
    let summaryLines: [String]?
}

struct WeeklyInsightResponse: Codable, Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let cta: String
}

struct PlanMetadataItemResponse: Codable {
    let label: String
    let value: String
}

struct WeeklyPlanItemResponse: Codable, Identifiable {
    let id = UUID()
    let title: String
    let metadata: [PlanMetadataItemResponse]?
    let buttonTitle: String
    let buttonKind: ButtonKindResponse
}

struct DataAuthorizationItemResponse: Codable, Identifiable {
    let id = UUID()
    let scope: String
    let status: String
    let actionTitle: String
    let buttonKind: ButtonKindResponse
}

struct SettingPreferenceResponse: Codable, Identifiable {
    let id = UUID()
    let title: String
    let enabled: Bool
}

struct ProfileLinkResponse: Codable, Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

struct ProfileIdentityResponse: Codable {
    let initials: String
    let displayName: String
    let email: String
    let lastSyncLabel: String
    let experimentTag: String
}

struct ProfileDataStrategyResponse: Codable {
    let summary: String
    let actions: [ActionButtonResponse]?
}

struct TodayDashboardPayload: Codable {
    let context: ScreenContextResponse
    let plan: MicroHabitPlanResponse
    let insight: HabitInsightResponse
    let quickActions: [HabitQuickActionResponse]
    let chatThread: [CoachMessageResponse]
}

struct CoachDashboardPayload: Codable {
    let context: ScreenContextResponse
    let thread: [CoachMessageResponse]
    let recommendation: CoachRecommendationResponse
    let composer: CoachComposerResponse
}

struct LogDashboardPayload: Codable {
    let context: ScreenContextResponse
    let metrics: [HabitLogMetricResponse]
    let timeline: [HabitTimelineEntryResponse]
    let manualCapture: ManualCaptureGuideResponse
}

struct WeeklyDashboardPayload: Codable {
    let context: ScreenContextResponse
    let summary: WeeklySummaryResponse
    let insights: [WeeklyInsightResponse]
    let plan: [WeeklyPlanItemResponse]
}

struct ProfileDashboardPayload: Codable {
    let context: ScreenContextResponse
    let identity: ProfileIdentityResponse
    let dataStrategy: ProfileDataStrategyResponse
    let settings: [SettingPreferenceResponse]
    let links: [ProfileLinkResponse]
    let dataAuthorizations: [DataAuthorizationItemResponse]
}
