import SwiftUI

struct TodayView: View {
    private let plan = HabitMockData.microHabitPlan
    private let insight = HabitMockData.nightInsight
    private let quickActions = HabitMockData.quickActions
    private let chatMessages = HabitMockData.chatMessages

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                HabitStatusBar(time: "09:41")

                HabitScreenHeader(
                    timestamp: "2025 年 3 月 21 日",
                    title: "今日 · 成功率 78%",
                    subtitle: nil,
                    badge: .init(text: "微目标强化 1", style: .primary),
                    goalChip: "目标：睡眠修复"
                )

                microHabitCard
                insightCard
                quickActionCard
                chatCard
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
    }

    private var microHabitCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(plan.title)
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                HabitBadge(text: "推荐中", style: .primary)
            }
            .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)

            Text(plan.summary)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HabitMetadataRow(items: plan.metadata)

            HStack(spacing: 12) {
                ForEach(plan.actions) { action in
                    Button(action.title, action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: action.kind))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var insightCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(insight.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: insight.evidenceLevel, style: .warning)
            }

            Text(insight.body)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                ForEach(insight.actions) { action in
                    Button(action.title, action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: action.kind))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var quickActionCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("一键执行")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: "计时器", style: .outline)
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(quickActions) { action in
                    QuickActionTile(
                        title: action.title,
                        subtitle: action.domain,
                        caption: action.caption
                    )
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var chatCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(chatMessages) { message in
                CoachBubble(
                    role: message.role == .ai ? .ai : .user,
                    text: message.text
                )
            }

            HStack(spacing: 12) {
                Button("一键采纳建议", action: {})
                    .buttonStyle(HabitCapsuleButtonStyle(kind: .primary))
                Button("改成 2 组", action: {})
                    .buttonStyle(HabitCapsuleButtonStyle(kind: .ghost))
            }

            VStack(spacing: 12) {
                TextField("说说你此刻的状态…", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)

                HStack {
                    Spacer()
                    Button("发送", action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: .primary))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }
}

#Preview {
    TodayView()
}
