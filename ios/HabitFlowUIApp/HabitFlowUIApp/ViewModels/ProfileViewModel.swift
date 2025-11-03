import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var context: ScreenContextModel
    @Published private(set) var identity: ProfileIdentityModel
    @Published private(set) var dataStrategy: ProfileDataStrategyModel
    @Published private(set) var settings: [SettingPreference]
    @Published private(set) var links: [ProfileLink]
    @Published private(set) var dataAuthorizations: [DataAuthorizationItem]
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
        let fallback = ProfileViewModel.makeFallback()
        self.context = fallback.context
        self.identity = fallback.identity
        self.dataStrategy = fallback.dataStrategy
        self.settings = fallback.settings
        self.links = fallback.links
        self.dataAuthorizations = fallback.dataAuthorizations
    }

    func load() async {
        if isLoading { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let payload = try await api.fetchProfileDashboard(userId: userId)
            context = ScreenContextModel(
                statusBarTime: payload.context.statusBarTime,
                timestamp: payload.context.timestampLabel,
                title: payload.context.titleText,
                subtitle: payload.context.subtitleText,
                goalChip: payload.context.goalChip,
                badge: payload.context.badge.map { HabitScreenHeader.Badge(text: $0.text, style: HabitBadge.Style.from($0.style)) }
            )
            identity = ProfileIdentityModel(response: payload.identity)
            dataStrategy = ProfileDataStrategyModel(response: payload.dataStrategy)
            settings = payload.settings.map(SettingPreference.init(response:))
            links = payload.links.map(ProfileLink.init(response:))
            dataAuthorizations = payload.dataAuthorizations.map(DataAuthorizationItem.init(response:))
            errorMessage = nil
        } catch {
            errorMessage = "账号中心数据加载失败，已回退到示例状态。"
            applyFallback()
        }
    }

    private func applyFallback() {
        let fallback = ProfileViewModel.makeFallback()
        context = fallback.context
        identity = fallback.identity
        dataStrategy = fallback.dataStrategy
        settings = fallback.settings
        links = fallback.links
        dataAuthorizations = fallback.dataAuthorizations
    }

    private static func makeFallback() -> (context: ScreenContextModel, identity: ProfileIdentityModel, dataStrategy: ProfileDataStrategyModel, settings: [SettingPreference], links: [ProfileLink], dataAuthorizations: [DataAuthorizationItem]) {
        let context = ScreenContextModel(
            statusBarTime: "09:45",
            timestamp: "账号中心",
            title: "我 · 偏好与隐私",
            subtitle: "实验版本：V0.2",
            goalChip: "敏感数据仅本地加密",
            badge: HabitScreenHeader.Badge(text: "安全同步", style: .primary)
        )
        let identity = ProfileIdentityModel(
            initials: "LY",
            displayName: "Lydia Yang",
            email: "lydia.yang@habitflow.app",
            lastSyncLabel: "最近同步 09:32",
            experimentTag: "Prompt Lab 内测"
        )
        let dataStrategy = ProfileDataStrategyModel(
            summary: "行为数据默认保存在本地，同步与训练前会自动去标识化。可随时发起“清除训练数据”，离线模式也能提供通用建议。",
            actions: [
                HabitActionButton(title: "管理授权", kind: .ghost),
                HabitActionButton(title: "了解安全设计", kind: .link)
            ]
        )
        return (
            context,
            identity,
            dataStrategy,
            HabitMockData.settingPreferences,
            HabitMockData.profileLinks,
            HabitMockData.dataAuthorizations
        )
    }
}
