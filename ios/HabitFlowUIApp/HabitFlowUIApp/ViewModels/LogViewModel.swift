import Foundation

@MainActor
final class LogViewModel: ObservableObject {
    @Published private(set) var context: ScreenContextModel
    @Published private(set) var metrics: [HabitLogMetric]
    @Published private(set) var timeline: [HabitTimelineEntry]
    @Published private(set) var manualCapture: ManualCaptureModel
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
        let fallback = LogViewModel.makeFallback()
        self.context = fallback.context
        self.metrics = fallback.metrics
        self.timeline = fallback.timeline
        self.manualCapture = fallback.manualCapture
    }

    func load() async {
        if isLoading { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let payload = try await api.fetchLogDashboard(userId: userId)
            context = ScreenContextModel(
                statusBarTime: payload.context.statusBarTime,
                timestamp: payload.context.timestampLabel,
                title: payload.context.titleText,
                subtitle: payload.context.subtitleText,
                goalChip: payload.context.goalChip,
                badge: payload.context.badge.map { HabitScreenHeader.Badge(text: $0.text, style: HabitBadge.Style.from($0.style)) }
            )
            metrics = payload.metrics.map(HabitLogMetric.init(response:))
            timeline = payload.timeline.map(HabitTimelineEntry.init(response:))
            manualCapture = ManualCaptureModel(response: payload.manualCapture)
            errorMessage = nil
        } catch {
            errorMessage = "记录面板数据加载失败，已回退到示例。"
            applyFallback()
        }
    }

    private func applyFallback() {
        let fallback = LogViewModel.makeFallback()
        context = fallback.context
        metrics = fallback.metrics
        timeline = fallback.timeline
        manualCapture = fallback.manualCapture
    }

    private static func makeFallback() -> (context: ScreenContextModel, metrics: [HabitLogMetric], timeline: [HabitTimelineEntry], manualCapture: ManualCaptureModel) {
        let context = ScreenContextModel(
            statusBarTime: "09:43",
            timestamp: "记录 · 自动 + 手动",
            title: "数据捕捉",
            subtitle: nil,
            goalChip: "来源：HealthKit / 手动",
            badge: HabitScreenHeader.Badge(text: "同步完成", style: .primary)
        )
        let manualCapture = ManualCaptureModel(
            headline: "快速记录",
            body: "已与 Apple Watch 同步成功，情绪打卡、事件标签支持语音 / 打字两种方式。",
            buttonTitle: "新增记录",
            buttonKind: .primary,
            badgeText: "支持语音",
            badgeStyle: .primary
        )
        return (
            context,
            HabitMockData.logMetrics,
            HabitMockData.timeline,
            manualCapture
        )
    }
}
