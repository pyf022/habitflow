import SwiftUI

struct ProfileView: View {
    private let settings = HabitMockData.settingPreferences
    private let links = HabitMockData.profileLinks
    private let authorizations = HabitMockData.dataAuthorizations

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                HabitStatusBar(time: "09:45")

                HabitScreenHeader(
                    timestamp: "账号中心",
                    title: "我 · 偏好与隐私",
                    subtitle: "实验版本：V0.2",
                    badge: .init(text: "安全同步", style: .primary),
                    goalChip: "敏感数据仅本地加密"
                )

                profileCard
                dataStrategyCard
                authorizationMatrix
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
    }

    private var profileCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 16) {
                Circle()
                    .fill(HabitFlowTheme.ColorPalette.primary.opacity(0.18))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text("LY")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text("Lydia Yang")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                    Text("lydia.yang@habitflow.app")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                    Text("最近同步 09:32 · Prompt Lab 内测")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                }
            }

            VStack(spacing: 12) {
                ForEach(settings) { setting in
                    SettingToggleRow(title: setting.title, isOn: setting.isOn)
                    if setting.id != settings.last?.id {
                        Divider()
                            .background(HabitFlowTheme.ColorPalette.divider.opacity(0.4))
                    }
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                ForEach(links) { link in
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
                    if link.id != links.last?.id {
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

            Text("行为数据默认保存在本地，同步、训练前会自动去标识化。可随时发起“清除训练数据”，离线模式也能提供通用建议。")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                Button("管理授权", action: {})
                    .buttonStyle(HabitCapsuleButtonStyle(kind: .ghost))
                Button("了解安全设计", action: {})
                    .buttonStyle(HabitCapsuleButtonStyle(kind: .link))
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
                ForEach(authorizations) { item in
                    PlanRowView(
                        title: item.scope,
                        metadata: [
                            .init(label: item.status, value: "")
                        ],
                        buttonTitle: item.actionTitle,
                        buttonKind: item.kind
                    )
                    if item.id != authorizations.last?.id {
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
