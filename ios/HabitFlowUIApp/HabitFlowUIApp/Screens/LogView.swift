import SwiftUI

struct LogView: View {
    private let metrics = HabitMockData.logMetrics
    private let timeline = HabitMockData.timeline

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                HabitStatusBar(time: "09:43")

                HabitScreenHeader(
                    timestamp: "记录 · 自动 + 手动",
                    title: "数据捕捉",
                    subtitle: nil,
                    badge: .init(text: "同步完成", style: .primary),
                    goalChip: "来源：HealthKit / 手动"
                )

                metricGrid
                timelineSection
                manualCaptureCard
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
    }

    private var metricGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("今日概览")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(metrics) { metric in
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
                HabitBadge(text: "按时序", style: .outline)
            }

            VStack(spacing: 16) {
                ForEach(timeline) { event in
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
                Text("快速记录")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: "支持语音", style: .primary)
            }

            Text("与 Apple Watch 同步成功，情绪打卡、事件标签支持语音 / 打字两种方式。")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)

            Button("新增记录", action: {})
                .buttonStyle(HabitCapsuleButtonStyle(kind: .primary))
        }
        .padding(18)
        .habitCardBackground()
    }
}

#Preview {
    LogView()
}
