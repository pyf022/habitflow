import Foundation

@MainActor
final class TodayViewModel: ObservableObject {
    @Published private(set) var context: ScreenContextModel
    @Published private(set) var plan: MicroHabitPlan
    @Published private(set) var insight: HabitInsight
    @Published private(set) var quickActions: [HabitQuickAction]
    @Published private(set) var chatThread: [CoachMessage]
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
        let fallback = TodayViewModel.makeFallback()
        self.context = fallback.context
        self.plan = fallback.plan
        self.insight = fallback.insight
        self.quickActions = fallback.quickActions
        self.chatThread = fallback.chatThread
    }

    func load() async {
        if isLoading { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let payload = try await api.fetchTodayDashboard(userId: userId)
            context = ScreenContextModel(
                statusBarTime: payload.context.statusBarTime,
                timestamp: payload.context.timestampLabel,
                title: payload.context.titleText,
                subtitle: payload.context.subtitleText,
                goalChip: payload.context.goalChip,
                badge: payload.context.badge.map { HabitScreenHeader.Badge(text: $0.text, style: HabitBadge.Style.from($0.style)) }
            )
            plan = MicroHabitPlan(response: payload.plan)
            insight = HabitInsight(response: payload.insight)
            quickActions = payload.quickActions.map(HabitQuickAction.init(response:))
            chatThread = payload.chatThread.map(CoachMessage.init(response:))
            errorMessage = nil
        } catch {
            errorMessage = "无法连接服务器，已使用离线示例数据。"
            applyFallback()
        }
    }

    private func applyFallback() {
        let fallback = TodayViewModel.makeFallback()
        context = fallback.context
        plan = fallback.plan
        insight = fallback.insight
        quickActions = fallback.quickActions
        chatThread = fallback.chatThread
    }

    private static func makeFallback() -> (context: ScreenContextModel, plan: MicroHabitPlan, insight: HabitInsight, quickActions: [HabitQuickAction], chatThread: [CoachMessage]) {
        let context = ScreenContextModel(
            statusBarTime: "09:41",
            timestamp: "2025 年 3 月 21 日",
            title: "今日 · 成功率 78%",
            subtitle: nil,
            goalChip: "目标：睡眠修复",
            badge: HabitScreenHeader.Badge(text: "微目标强化 1", style: .primary)
        )
        return (
            context,
            HabitMockData.microHabitPlan,
            HabitMockData.nightInsight,
            HabitMockData.quickActions,
            HabitMockData.chatMessages
        )
    }
}
