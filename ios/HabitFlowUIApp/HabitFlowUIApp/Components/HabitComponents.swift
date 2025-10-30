import SwiftUI

struct HabitStatusBar: View {
    var time: String
    var batteryLevel: Int = 82

    var body: some View {
        HStack {
            Text(time)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued.opacity(0.9))

            Spacer()

            HStack(spacing: 8) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                Image(systemName: "wifi")
                BatteryView(level: batteryLevel)
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued.opacity(0.8))
        }
        .padding(.horizontal, 6)
    }
}

private struct BatteryView: View {
    var level: Int

    var body: some View {
        HStack(spacing: 4) {
            Text("\(level)%")
            Image(systemName: "battery.100")
        }
    }
}

struct HabitScreenHeader: View {
    struct Badge {
        var text: String
        var style: HabitBadge.Style
    }

    var timestamp: String
    var title: String
    var subtitle: String?
    var badge: Badge?
    var goalChip: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(timestamp.uppercased())
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued.opacity(0.8))
                        .tracking(0.8)

                    HStack(spacing: 10) {
                        Text(title)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                        if let badge {
                            HabitBadge(text: badge.text, style: badge.style)
                        }
                    }

                    if let subtitle {
                        Text(subtitle)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                    }
                }

                Spacer(minLength: 12)

                if let goalChip {
                    HabitChip(text: goalChip)
                }
            }
        }
    }
}

struct HabitChip: View {
    var text: String

    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(Color(red: 30 / 255, green: 41 / 255, blue: 59 / 255, opacity: 0.72))
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(Color(red: 241 / 255, green: 245 / 255, blue: 249 / 255, opacity: 0.9))
            )
            .overlay(
                Capsule()
                    .stroke(Color(red: 148 / 255, green: 163 / 255, blue: 184 / 255, opacity: 0.24), lineWidth: 1)
            )
    }
}

struct HabitBadge: View {
    enum Style {
        case primary
        case outline
        case warning

        var foreground: Color {
            switch self {
            case .primary:
                return HabitFlowTheme.ColorPalette.primary
            case .outline:
                return HabitFlowTheme.ColorPalette.textSubdued
            case .warning:
                return HabitFlowTheme.ColorPalette.warning
            }
        }

        var background: Color {
            switch self {
            case .primary:
                return HabitFlowTheme.ColorPalette.primary.opacity(0.12)
            case .outline:
                return .clear
            case .warning:
                return HabitFlowTheme.ColorPalette.warning.opacity(0.12)
            }
        }

        var borderColor: Color {
            switch self {
            case .primary:
                return .clear
            case .outline:
                return HabitFlowTheme.ColorPalette.divider
            case .warning:
                return .clear
            }
        }
    }

    var text: String
    var style: Style

    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(style.foreground)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(
                Capsule()
                    .fill(style.background)
            )
            .overlay(
                Capsule()
                    .stroke(style.borderColor, lineWidth: style == .outline ? 1 : 0)
            )
    }
}

enum HabitButtonKind: Equatable {
    case primary
    case ghost
    case tertiary
    case link

    var background: Color {
        switch self {
        case .primary:
            return HabitFlowTheme.ColorPalette.primary
        case .ghost:
            return Color.white.opacity(0.001)
        case .tertiary:
            return HabitFlowTheme.ColorPalette.primary.opacity(0.08)
        case .link:
            return .clear
        }
    }

    var foreground: Color {
        switch self {
        case .primary:
            return .white
        case .ghost:
            return HabitFlowTheme.ColorPalette.textSubdued
        case .tertiary:
            return HabitFlowTheme.ColorPalette.primary
        case .link:
            return HabitFlowTheme.ColorPalette.primary
        }
    }

    var borderColor: Color {
        switch self {
        case .primary:
            return .clear
        case .ghost:
            return Color(red: 148 / 255, green: 163 / 255, blue: 184 / 255, opacity: 0.32)
        case .tertiary:
            return .clear
        case .link:
            return .clear
        }
    }
}

struct HabitCapsuleButtonStyle: ButtonStyle {
    var kind: HabitButtonKind

    func makeBody(configuration: Configuration) -> some View {
        Group {
            if kind == .link {
                configuration.label
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(kind.foreground)
                    .underline(configuration.isPressed, color: kind.foreground.opacity(0.6))
                    .opacity(configuration.isPressed ? 0.6 : 1.0)
            } else {
                configuration.label
                    .font(.system(size: 15, weight: .medium))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(
                        Capsule()
                            .fill(kind.background)
                    )
                    .overlay(
                        Capsule()
                            .stroke(kind.borderColor, lineWidth: kind == .ghost ? 1 : 0)
                    )
                    .foregroundColor(kind.foreground)
                    .opacity(configuration.isPressed ? 0.7 : 1.0)
            }
        }
    }
}

struct HabitMetadataRow: View {
    var items: [String]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(HabitFlowTheme.ColorPalette.surfaceBackground.opacity(0.8))
                    )
            }
        }
    }
}

struct QuickActionTile: View {
    var title: String
    var subtitle: String
    var caption: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(subtitle)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .textCase(.uppercase)
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
            Text(caption)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: HabitFlowTheme.Radii.small, style: .continuous)
                .fill(Color.white.opacity(0.72))
                .overlay(
                    RoundedRectangle(cornerRadius: HabitFlowTheme.Radii.small, style: .continuous)
                        .stroke(Color.white.opacity(0.6), lineWidth: 1)
                )
        )
    }
}

struct CoachBubble: View {
    enum Role {
        case user
        case ai
    }

    var role: Role
    var text: String

    var body: some View {
        HStack {
            if role == .ai {
                bubble
                Spacer(minLength: 40)
            } else {
                Spacer(minLength: 40)
                bubble
            }
        }
    }

    private var bubble: some View {
        Text(text)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .foregroundColor(role == .ai ? HabitFlowTheme.ColorPalette.textPrimary : .white)
            .background(
                RoundedRectangle(cornerRadius: HabitFlowTheme.Radii.small, style: .continuous)
                    .fill(role == .ai ? Color.white : HabitFlowTheme.ColorPalette.primary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: HabitFlowTheme.Radii.small, style: .continuous)
                    .stroke(Color.black.opacity(role == .ai ? 0.05 : 0), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 20, x: 0, y: 12)
    }
}

struct MetricTile: View {
    var label: String
    var value: String
    var detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
            Text(detail)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
        }
        .padding()
        .habitCardBackground(cornerRadius: HabitFlowTheme.Radii.small)
    }
}

struct TimelineEntryView: View {
    var time: String
    var title: String
    var meta: String
    var detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(time)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .frame(width: 48, alignment: .leading)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Text(meta)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                Text(detail)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
            }
            .padding(14)
            .habitCardBackground(cornerRadius: HabitFlowTheme.Radii.small)
        }
    }
}

struct PlanRowView: View {
    struct MetadataItem: Identifiable {
        let id = UUID()
        var label: String
        var value: String
    }

    var title: String
    var metadata: [MetadataItem]
    var buttonTitle: String
    var buttonKind: HabitButtonKind

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                HStack(spacing: 12) {
                    ForEach(metadata) { item in
                        if item.value.isEmpty {
                            Text(item.label)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                        } else {
                            Text("\(item.label)：\(item.value)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                        }
                    }
                }
            }

            Spacer()

            Button(buttonTitle, action: {})
                .buttonStyle(HabitCapsuleButtonStyle(kind: buttonKind))
        }
    }
}

struct SettingToggleRow: View {
    var title: String
    var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
            Spacer()
            Toggle("", isOn: .constant(isOn))
                .toggleStyle(SwitchToggleStyle(tint: HabitFlowTheme.ColorPalette.primary))
                .labelsHidden()
                .disabled(true)
                .opacity(0.9)
        }
        .padding(.vertical, 6)
    }
}
