import Foundation

@MainActor
final class CoachViewModel: ObservableObject {
    @Published private(set) var context: ScreenContextModel
    @Published private(set) var thread: [CoachMessage]
    @Published private(set) var recommendation: CoachRecommendation
    @Published private(set) var closingHint: String
    @Published private(set) var composer: CoachComposerModel
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
        let fallback = CoachViewModel.makeFallback()
        self.context = fallback.context
        self.thread = fallback.thread
        self.recommendation = fallback.recommendation
        self.closingHint = fallback.closingHint
        self.composer = fallback.composer
    }

    func load() async {
        if isLoading { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let payload = try await api.fetchCoachDashboard(userId: userId)
            context = ScreenContextModel(
                statusBarTime: payload.context.statusBarTime,
                timestamp: payload.context.timestampLabel,
                title: payload.context.titleText,
                subtitle: payload.context.subtitleText,
                goalChip: payload.context.goalChip,
                badge: payload.context.badge.map { HabitScreenHeader.Badge(text: $0.text, style: HabitBadge.Style.from($0.style)) }
            )
            thread = payload.thread.map(CoachMessage.init(response:))
            recommendation = CoachRecommendation(response: payload.recommendation)
            closingHint = payload.recommendation.closingHint ?? CoachViewModel.makeFallback().closingHint
            composer = CoachComposerModel(response: payload.composer)
            errorMessage = nil
        } catch {
            errorMessage = "教练数据暂时不可用，已回退至示例对话。"
            applyFallback()
        }
    }

    private func applyFallback() {
        let fallback = CoachViewModel.makeFallback()
        context = fallback.context
        thread = fallback.thread
        recommendation = fallback.recommendation
        closingHint = fallback.closingHint
        composer = fallback.composer
    }

    private static func makeFallback() -> (context: ScreenContextModel, thread: [CoachMessage], recommendation: CoachRecommendation, closingHint: String, composer: CoachComposerModel) {
        let context = ScreenContextModel(
            statusBarTime: "09:42",
            timestamp: "教练对话",
            title: "AI 教练",
            subtitle: "上次同步 15:20",
            goalChip: "教练组：睡眠 + 活动",
            badge: HabitScreenHeader.Badge(text: "实时同步", style: .primary)
        )
        let composer = CoachComposerModel(
            prompt: "告诉教练你目前的状态。",
            placeholder: "例如：午饭后困倦，临时会议调整",
            submitTitle: "发送",
            buttonKind: .primary
        )
        return (
            context,
            HabitMockData.chatMessages,
            HabitMockData.coachRecommendation,
            "另外：继续保持 22:15 熄屏节奏，8 小时达成睡眠挑战可解锁下一阶段。",
            composer
        )
    }
}
