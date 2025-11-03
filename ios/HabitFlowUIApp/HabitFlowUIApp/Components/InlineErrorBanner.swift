import SwiftUI

struct InlineErrorBanner: View {
    var message: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(HabitFlowTheme.ColorPalette.warning)
            Text(message)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(HabitFlowTheme.ColorPalette.warning)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: HabitFlowTheme.Radii.small, style: .continuous)
                .fill(HabitFlowTheme.ColorPalette.warning.opacity(0.12))
        )
    }
}

#Preview {
    InlineErrorBanner(message: "无法连接服务器，已使用离线示例数据。")
        .padding()
        .background(Color.white)
}
