import SwiftUI

struct CoachView: View {
    @StateObject private var viewModel = CoachViewModel()

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

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.thread) { message in
                        CoachBubble(
                            role: message.role == .ai ? .ai : .user,
                            text: message.text
                        )
                    }
                }

                recommendationCard
                closingHint
                chatComposer
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 22)
        }
        .habitScreenBackground()
        .task { await viewModel.load() }
    }

    private var recommendationCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("推荐依据")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: viewModel.recommendation.evidenceTag, style: .warning)
            }

            HStack(spacing: 12) {
                Text(viewModel.recommendation.dataWindow)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                Spacer()
            }

            Text(viewModel.recommendation.summary)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                ForEach(viewModel.recommendation.actions) { action in
                    Button(action.title, action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: action.kind))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var closingHint: some View {
        Text(viewModel.closingHint)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: HabitFlowTheme.Radii.small, style: .continuous)
                    .fill(Color.white.opacity(0.72))
            )
    }

    private var chatComposer: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.composer.prompt)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)

            VStack(spacing: 12) {
                TextField(viewModel.composer.placeholder, text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)

                HStack {
                    Spacer()
                    Button(viewModel.composer.submitTitle, action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: viewModel.composer.buttonKind))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }
}

#Preview {
    CoachView()
}
