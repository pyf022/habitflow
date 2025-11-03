import SwiftUI

struct WeeklyView: View {
    @StateObject private var viewModel = WeeklyViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
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

                weeklyHero
                insightList
                planCard
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
        .task { await viewModel.load() }
    }

    private var weeklyHero: some View {
        HStack(spacing: 18) {
            WeeklyProgressRing(progress: viewModel.summary.progress)
                .frame(width: 120, height: 120)

            VStack(alignment: .leading, spacing: 8) {
                Text("综合完成率 \(Int(viewModel.summary.progress * 100))%")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)

                HStack(spacing: 6) {
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(HabitFlowTheme.ColorPalette.success)
                    Text("\(viewModel.summary.trendValue) \(viewModel.summary.trendLabel)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(HabitFlowTheme.ColorPalette.success)
                }

                ForEach(viewModel.summary.summaryLines, id: \.self) { line in
                    Text(line)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(18)
        .habitCardBackground(cornerRadius: HabitFlowTheme.Radii.large)
    }

    private var insightList: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("重点洞察")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)

            VStack(spacing: 16) {
                ForEach(viewModel.insights) { insight in
                    HStack(alignment: .top, spacing: 16) {
                        Circle()
                            .fill(HabitFlowTheme.ColorPalette.primary.opacity(0.2))
                            .frame(width: 12, height: 12)
                            .overlay(Circle().stroke(HabitFlowTheme.ColorPalette.primary, lineWidth: 2))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(insight.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                            Text(insight.detail)
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                                .fixedSize(horizontal: false, vertical: true)
                            Button(insight.cta, action: {})
                                .buttonStyle(HabitCapsuleButtonStyle(kind: .link))
                        }
                    }
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var planCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("下周微计划")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: "AI 推荐", style: .outline)
            }

            VStack(spacing: 14) {
                ForEach(viewModel.plan) { item in
                    PlanRowView(
                        title: item.title,
                        metadata: item.metadata,
                        buttonTitle: item.buttonTitle,
                        buttonKind: item.buttonKind
                    )
                    if item.id != viewModel.plan.last?.id {
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

private struct WeeklyProgressRing: View {
    var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 16)
                .foregroundColor(HabitFlowTheme.ColorPalette.primary.opacity(0.15))

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            HabitFlowTheme.ColorPalette.primary,
                            HabitFlowTheme.ColorPalette.primaryDark
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 16, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            VStack(spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.primary)
                Text("进度")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
            }
        }
    }
}

#Preview {
    WeeklyView()
}
