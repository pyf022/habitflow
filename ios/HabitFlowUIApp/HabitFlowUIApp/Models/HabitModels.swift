import Foundation

struct HabitActionButton: Identifiable {
    let id = UUID()
    var title: String
    var kind: HabitButtonKind
}

struct MicroHabitPlan {
    var title: String
    var summary: String
    var metadata: [String]
    var actions: [HabitActionButton]
}

struct HabitInsight {
    var title: String
    var evidenceLevel: String
    var body: String
    var actions: [HabitActionButton]
}

struct HabitQuickAction: Identifiable {
    let id = UUID()
    var domain: String
    var title: String
    var caption: String
}

struct CoachMessage: Identifiable {
    enum Role {
        case user
        case ai
    }

    let id = UUID()
    var role: Role
    var text: String
}

struct CoachRecommendation {
    var evidenceTag: String
    var dataWindow: String
    var summary: String
    var actions: [HabitActionButton]
}

struct HabitLogMetric: Identifiable {
    let id = UUID()
    var label: String
    var value: String
    var detail: String
}

struct HabitTimelineEntry: Identifiable {
    let id = UUID()
    var time: String
    var title: String
    var meta: String
    var detail: String
}

struct WeeklyInsight: Identifiable {
    let id = UUID()
    var title: String
    var detail: String
    var cta: String
}

struct WeeklyPlanItem: Identifiable {
    let id = UUID()
    var title: String
    var metadata: [PlanRowView.MetadataItem]
    var buttonTitle: String
    var buttonKind: HabitButtonKind
}

struct DataAuthorizationItem: Identifiable {
    let id = UUID()
    var scope: String
    var status: String
    var actionTitle: String
    var kind: HabitButtonKind
}

struct SettingPreference: Identifiable {
    let id = UUID()
    var title: String
    var isOn: Bool
}

struct ProfileLink: Identifiable {
    let id = UUID()
    var title: String
    var icon: String
}

enum HabitMockData {
    static let microHabitPlan = MicroHabitPlan(
        title: "夜间微目标",
        summary: "22:20 洗漱 3 分钟后同步切换夜间模式，过去 48 小时平均入睡潜伏缩短 14 分钟。近 7 天完成 5 次，可继续保持节奏。",
        metadata: ["睡眠 · 稳态挑战", "预计耗时 5 分钟"],
        actions: [
            HabitActionButton(title: "准时执行", kind: .primary),
            HabitActionButton(title: "改到明早", kind: .ghost),
            HabitActionButton(title: "加入播放单", kind: .tertiary)
        ]
    )

    static let nightInsight = HabitInsight(
        title: "晚间亮屏提醒",
        evidenceLevel: "证据：Mid",
        body: "最近 7 天 22:30 后平均亮屏 38 分钟，深睡比例下滑 6%。建议 22:15 自动切换暖色模式，先提前 2 分钟熄屏。",
        actions: [
            HabitActionButton(title: "马上执行", kind: .primary),
            HabitActionButton(title: "了解原因", kind: .link)
        ]
    )

    static let quickActions: [HabitQuickAction] = [
        HabitQuickAction(domain: "晨间", title: "伸展唤醒 2 轮", caption: "帮助稳定起床心率"),
        HabitQuickAction(domain: "活动", title: "楼梯间快步 2 组", caption: "15:00 后补能量"),
        HabitQuickAction(domain: "专注", title: "极简写卡 15 分钟", caption: "17:00 前完成复盘")
    ]

    static let chatMessages: [CoachMessage] = [
        CoachMessage(role: .user, text: "感觉最近下午快要崩溃，台阶 2 组的计划能调整吗？"),
        CoachMessage(role: .ai, text: "可以向后 15 分钟。从 14:45 开始准备，15:00-15:05 快步，拉伸 2 分钟后再回工位。"),
        CoachMessage(role: .ai, text: "周末 17:00 后 3 次补觉请求触发了入睡延迟 11 分钟，建议保留一组轻量呼吸。")
    ]

    static let coachRecommendation = CoachRecommendation(
        evidenceTag: "散点回归 · Mid",
        dataWindow: "数据窗：Past 5d",
        summary: "过去 5 天 17:00 后补眠 3 次，会把入睡潜伏拉长约 11 分钟。建议以“伸展 + 台阶 1 组”收尾作为替代。",
        actions: [
            HabitActionButton(title: "按建议执行", kind: .primary),
            HabitActionButton(title: "仅保留运动", kind: .ghost),
            HabitActionButton(title: "为什么推荐", kind: .link)
        ]
    )

    static let logMetrics: [HabitLogMetric] = [
        HabitLogMetric(label: "步数", value: "6,420", detail: "较 7 日均 +12%"),
        HabitLogMetric(label: "睡眠", value: "7 小时 18 分", detail: "深睡 24%"),
        HabitLogMetric(label: "情绪基线", value: "4 / 5", detail: "10:30 手动记录")
    ]

    static let timeline: [HabitTimelineEntry] = [
        HabitTimelineEntry(
            time: "06:55",
            title: "自动 · 睡眠结束",
            meta: "来源：Apple Watch",
            detail: "就寝 22:32 · 入睡潜伏 14 分钟 · 起床 06:55"
        ),
        HabitTimelineEntry(
            time: "10:30",
            title: "手动 · 情绪 / 状态",
            meta: "标签：平稳 · 精力 4/5",
            detail: "备注：外出访谈前焦虑度上升，台阶快走缓解"
        ),
        HabitTimelineEntry(
            time: "15:05",
            title: "自动 · 楼梯快走",
            meta: "来源：iPhone 动态",
            detail: "台阶 2 轮 · 心率峰值 136 bpm · 体感 7/10"
        ),
        HabitTimelineEntry(
            time: "22:15",
            title: "自动 · 夜间模式",
            meta: "来源：快捷指令",
            detail: "开启深蓝滤光，提醒：留出 5 分钟缓冲"
        )
    ]

    static let weeklyInsights: [WeeklyInsight] = [
        WeeklyInsight(
            title: "Top 影响因素 · 周末作息漂移",
            detail: "周末平均晚睡 45 分钟，周一入睡潜伏延长 18 分钟。",
            cta: "查看作息分布"
        ),
        WeeklyInsight(
            title: "晚间屏幕暴露",
            detail: "22:30 后平均亮屏 38 分钟，深睡比例下降 6%，可使用夜间暖屏联动。",
            cta: "调整自动化"
        ),
        WeeklyInsight(
            title: "午后低活跃",
            detail: "15:00-17:00 步数偏低 32%，与主观疲劳评分 4/5 高度相关。",
            cta: "加入补能计划"
        )
    ]

    static let weeklyPlan: [WeeklyPlanItem] = [
        WeeklyPlanItem(
            title: "22:20 洗漱 3 分钟 + 睡前换气",
            metadata: [
                .init(label: "提醒", value: "自动"),
                .init(label: "证据", value: "High")
            ],
            buttonTitle: "采纳",
            buttonKind: .tertiary
        ),
        WeeklyPlanItem(
            title: "15:00 台阶 2 轮快步",
            metadata: [
                .init(label: "环境", value: "室内可执行"),
                .init(label: "证据", value: "Mid")
            ],
            buttonTitle: "调整",
            buttonKind: .ghost
        ),
        WeeklyPlanItem(
            title: "21:45 自动切换夜间模式",
            metadata: [
                .init(label: "触发", value: "情境规则"),
                .init(label: "证据", value: "High")
            ],
            buttonTitle: "预览",
            buttonKind: .ghost
        )
    ]

    static let dataAuthorizations: [DataAuthorizationItem] = [
        DataAuthorizationItem(scope: "健康数据：步数 / 睡眠 / 心率", status: "状态：已授权", actionTitle: "管理", kind: .tertiary),
        DataAuthorizationItem(scope: "屏幕使用时间（iOS）", status: "状态：待授权", actionTitle: "去授权", kind: .ghost),
        DataAuthorizationItem(scope: "情绪日志（手动记录）", status: "状态：自动同步", actionTitle: "查看", kind: .ghost)
    ]

    static let settingPreferences: [SettingPreference] = [
        SettingPreference(title: "允许教练使用情境触发", isOn: true),
        SettingPreference(title: "夜间 22:30 后静音推送", isOn: true),
        SettingPreference(title: "参与新功能内测（Prompt Lab）", isOn: false)
    ]

    static let profileLinks: [ProfileLink] = [
        ProfileLink(title: "查看数据授权矩阵", icon: "shield.lefthalf.filled"),
        ProfileLink(title: "导出我的数据（JSON / CSV）", icon: "square.and.arrow.up"),
        ProfileLink(title: "查看隐私政策与使用条款", icon: "doc.richtext")
    ]
}
