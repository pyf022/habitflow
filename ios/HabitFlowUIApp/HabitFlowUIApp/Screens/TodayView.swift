import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                HabitStatusBar(time: viewModel.context.statusBarTime)

                HabitScreenHeader(
                    timestamp: viewModel.context.timestamp,
                    title: viewModel.context.title,
                    subtitle: viewModel.context.subtitle,
                    badge: viewModel.context.badge,
                    goalChip: viewModel.context.goalChip
                )

                if let errorMessage = viewModel.errorMessage {
                    InlineErrorBanner(message: errorMessage)
                }

                microHabitCard
                insightCard
                quickActionCard
                chatCard
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
        .task { await viewModel.load() }
    }

    private var microHabitCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(viewModel.plan.title)
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                HabitBadge(text: "推荐", style: .primary)
            }
            .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)

            Text(viewModel.plan.summary)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HabitMetadataRow(items: viewModel.plan.metadata)

            HStack(spacing: 12) {
                ForEach(viewModel.plan.actions) { action in
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
                Text(viewModel.insight.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: viewModel.insight.evidenceLevel, style: .warning)
            }

            Text(viewModel.insight.body)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                ForEach(viewModel.insight.actions) { action in
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
                ForEach(viewModel.quickActions) { action in
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
            ForEach(viewModel.chatThread) { message in
                CoachBubble(
                    role: message.role == .ai ? .ai : .user,
                    text: message.text
                )
            }

            HStack(spacing: 12) {
                Button("一键采纳建议", action: {})
                    .buttonStyle(HabitCapsuleButtonStyle(kind: .primary))
                Button("改成 2 轮", action: {})
                    .buttonStyle(HabitCapsuleButtonStyle(kind: .ghost))
            }

            VStack(spacing: 12) {
                TextField("说说你此刻的状态", text: .constant(""))
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
