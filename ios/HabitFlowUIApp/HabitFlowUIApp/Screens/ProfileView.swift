import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

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

                profileCard
                dataStrategyCard
                authorizationMatrix
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
        .task { await viewModel.load() }
    }

    private var profileCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 16) {
                Circle()
                    .fill(HabitFlowTheme.ColorPalette.primary.opacity(0.18))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(viewModel.identity.initials)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.identity.displayName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                    Text(viewModel.identity.email)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                    Text("\(viewModel.identity.lastSyncLabel) · \(viewModel.identity.experimentTag)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                }
            }

            VStack(spacing: 12) {
                ForEach(viewModel.settings) { setting in
                    SettingToggleRow(title: setting.title, isOn: setting.isOn)
                    if setting.id != viewModel.settings.last?.id {
                        Divider()
                            .background(HabitFlowTheme.ColorPalette.divider.opacity(0.4))
                    }
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.links) { link in
                    HStack {
                        Image(systemName: link.icon)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                        Text(link.title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(HabitFlowTheme.ColorPalette.primary.opacity(0.7))
                    }
                    if link.id != viewModel.links.last?.id {
                        Divider()
                            .background(HabitFlowTheme.ColorPalette.divider.opacity(0.4))
                    }
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var dataStrategyCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("🛡 数据策略摘要")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: "隐私中心", style: .outline)
            }

            Text(viewModel.dataStrategy.summary)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                ForEach(viewModel.dataStrategy.actions) { action in
                    Button(action.title, action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: action.kind))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var authorizationMatrix: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("数据授权矩阵")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: "隐私中心", style: .outline)
            }

            VStack(spacing: 14) {
                ForEach(viewModel.dataAuthorizations) { item in
                    PlanRowView(
                        title: item.scope,
                        metadata: [.init(label: item.status, value: "")],
                        buttonTitle: item.actionTitle,
                        buttonKind: item.kind
                    )
                    if item.id != viewModel.dataAuthorizations.last?.id {
                        Divider()
                            .background(HabitFlowTheme.ColorPalette.divider.opacity(0.4))
                    }
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }
}

#Preview {
    ProfileView()
}
