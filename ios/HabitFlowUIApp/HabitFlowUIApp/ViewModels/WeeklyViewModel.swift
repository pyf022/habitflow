import Foundation

@MainActor
final class WeeklyViewModel: ObservableObject {
    @Published private(set) var context: ScreenContextModel
    @Published private(set) var summary: WeeklySummaryModel
    @Published private(set) var insights: [WeeklyInsight]
    @Published private(set) var plan: [WeeklyPlanItem]
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading = false

    private let api: HabitFlowAPI
    private let userId: Int

    init(
        api: HabitFlowAPI = .shared,
        userId: Int = 1
    ) {
        self.api = api
        self.userId = userId
        let fallback = WeeklyViewModel.makeFallback()
        self.context = fallback.context
        self.summary = fallback.summary
        self.insights = fallback.insights
        self.plan = fallback.plan
    }

    func load() async {
        if isLoading { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let payload = try await api.fetchWeeklyDashboard(userId: userId)
            context = ScreenContextModel(
                statusBarTime: payload.context.statusBarTime,
                timestamp: payload.context.timestampLabel,
                title: payload.context.titleText,
                subtitle: payload.context.subtitleText,
                goalChip: payload.context.goalChip,
                badge: payload.context.badge.map { HabitScreenHeader.Badge(text: $0.text, style: HabitBadge.Style.from($0.style)) }
            )
            summary = WeeklySummaryModel(response: payload.summary)
            insights = payload.insights.map(WeeklyInsight.init(response:))
            plan = payload.plan.map(WeeklyPlanItem.init(response:))
            errorMessage = nil
        } catch {
            errorMessage = "周报面板暂时不可用，已回退到示例数据。"
            applyFallback()
        }
    }

    private func applyFallback() {
        let fallback = WeeklyViewModel.makeFallback()
        context = fallback.context
        summary = fallback.summary
        insights = fallback.insights
        plan = fallback.plan
    }

    private static func makeFallback() -> (context: ScreenContextModel, summary: WeeklySummaryModel, insights: [WeeklyInsight], plan: [WeeklyPlanItem]) {
        let context = ScreenContextModel(
            statusBarTime: "09:44",
            timestamp: "第 14 周回顾",
            title: "周报 · 进度洞察",
            subtitle: "范围：3 月 17 日 - 3 月 23 日",
            goalChip: "周期目标：节律稳态",
            badge: HabitScreenHeader.Badge(text: "AI 推荐", style: .primary)
        )
        let summary = WeeklySummaryModel(
            progress: 0.62,
            trendLabel: "周环比",
            trendValue: "+8%",
            summaryLines: [
                "AI 推荐执行率 76%，夜间亮屏平均 26 分钟，心率恢复良好。",
                "睡眠挑战完成 3/4 次，建议继续保持周末作息勿漂移。"
            ]
        )
        return (
            context,
            summary,
            HabitMockData.weeklyInsights,
            HabitMockData.weeklyPlan
        )
    }
}
