import SwiftUI

enum HabitFlowTheme {
    enum ColorPalette {
        static let primary = Color(hex: "#2563EB")
        static let primaryDark = Color(hex: "#1D4ED8")
        static let success = Color(hex: "#1C7D4E")
        static let warning = Color(hex: "#B45309")
        static let danger = Color(hex: "#B42318")
        static let surfaceBackground = Color(hex: "#F6F7FA")
        static let surfaceCardTop = Color.white
        static let surfaceCardBottom = Color(hex: "#F7F9FD")
        static let textPrimary = Color(hex: "#1B1F2A")
        static let textSubdued = Color(hex: "#667085")
        static let divider = Color(hex: "#E3E6EE")
        static let glass = Color(red: 244 / 255, green: 246 / 255, blue: 251 / 255, opacity: 0.72)
    }

    enum Radii {
        static let large: CGFloat = 28
        static let medium: CGFloat = 20
        static let small: CGFloat = 14
    }

    enum Shadow {
        static let card = ShadowStyle(color: Color.black.opacity(0.08), radius: 30, y: 14)
        static let elevated = ShadowStyle(color: Color.black.opacity(0.12), radius: 40, y: 22)
    }

    struct ShadowStyle {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat

        init(color: Color, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }

    static let screenBackground = LinearGradient(
        colors: [
            Color.white,
            Color(hex: "#F3F4F8")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}

extension Color {
    init(hex: String) {
        let sanitized = hex.replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&int)

        let r, g, b, a: UInt64
        switch sanitized.count {
        case 8:
            (a, r, g, b) = ((int & 0xFF000000) >> 24, (int & 0x00FF0000) >> 16, (int & 0x0000FF00) >> 8, int & 0x000000FF)
        default:
            (a, r, g, b) = (255, (int & 0xFF0000) >> 16, (int & 0x00FF00) >> 8, int & 0x0000FF)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension View {
    func habitCardBackground(cornerRadius: CGFloat = HabitFlowTheme.Radii.medium) -> some View {
        background(
            LinearGradient(
                colors: [
                    HabitFlowTheme.ColorPalette.surfaceCardTop,
                    HabitFlowTheme.ColorPalette.surfaceCardBottom
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .shadow(
            color: HabitFlowTheme.Shadow.card.color,
            radius: HabitFlowTheme.Shadow.card.radius,
            x: HabitFlowTheme.Shadow.card.x,
            y: HabitFlowTheme.Shadow.card.y
        )
    }

    func habitScreenBackground() -> some View {
        background(HabitFlowTheme.screenBackground.ignoresSafeArea())
    }
}
