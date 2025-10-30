import SwiftUI

struct CoachView: View {
    private let thread = HabitMockData.chatMessages
    private let recommendation = HabitMockData.coachRecommendation

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                HabitStatusBar(time: "09:42")

                HabitScreenHeader(
                    timestamp: "教练对话",
                    title: "AI 教练",
                    subtitle: "上次同步 15:20",
                    badge: .init(text: "实时同步", style: .primary),
                    goalChip: "教练组：睡眠 + 活动"
                )

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(thread) { message in
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
    }

    private var recommendationCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("推荐依据")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textPrimary)
                Spacer()
                HabitBadge(text: recommendation.evidenceTag, style: .warning)
            }

            HStack(spacing: 12) {
                Text(recommendation.dataWindow)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                Spacer()
            }

            Text(recommendation.summary)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                ForEach(recommendation.actions) { action in
                    Button(action.title, action: {})
                        .buttonStyle(HabitCapsuleButtonStyle(kind: action.kind))
                }
            }
        }
        .padding(18)
        .habitCardBackground()
    }

    private var closingHint: some View {
        Text("另外：继续保持 22:15 熄屏节奏，48 小时达成睡眠挑战可解锁下一阶段。")
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
            Text("告诉教练你目前的状态…")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(HabitFlowTheme.ColorPalette.textSubdued)

            VStack(spacing: 12) {
                TextField("例如：午饭后困倦，临时会议调整", text: .constant(""))
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
    CoachView()
}
