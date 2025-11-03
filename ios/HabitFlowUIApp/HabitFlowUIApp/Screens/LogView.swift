import SwiftUI

struct LogView: View {
    @StateObject private var viewModel = LogViewModel()

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

                metricGrid
                timelineSection
                manualCaptureCard
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
        .task { await viewModel.load() }
    }

    private var metricGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("今日概览")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.metrics) { metric in
                    MetricTile(label: metric.label, value: metric.value, detail: metric.detail)
                }
            }
        }
    }

    private var timelineSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("捕捉时间线")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: "按时段", style: .outline)
            }

            VStack(spacing: 16) {
                ForEach(viewModel.timeline) { event in
                    TimelineEntryView(
                        time: event.time,
                        title: event.title,
                        meta: event.meta,
                        detail: event.detail
                    )
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var manualCaptureCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(viewModel.manualCapture.headline)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: viewModel.manualCapture.badgeText, style: viewModel.manualCapture.badgeStyle)
            }

            Text(viewModel.manualCapture.body)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            Button(viewModel.manualCapture.buttonTitle, action: {})
                .buttonStyle(HabitCapsuleButtonStyle(kind: viewModel.manualCapture.buttonKind))
        }
        .padding(18)
        .habitCardBackground()
    }
}

#Preview {
    LogView()
}
