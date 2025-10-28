// HabitFlow iOS — V1 Stubs (SwiftUI)
import SwiftUI
import Combine

struct CausalCard: View {
    let title: String
    let evidenceLevel: String // High/Mid/Low
    let body: String
    var onAccept: (() -> Void)?
    var onLearnMore: (() -> Void)?
    var bodyView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title).font(.headline)
                Spacer()
                EvidenceBadge(level: evidenceLevel)
            }
            Text(body).font(.subheadline)
            HStack {
                Button("采纳建议") { onAccept?() }.buttonStyle(.borderedProminent)
                Button("了解原因") { onLearnMore?() }.buttonStyle(.bordered)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
    }
    var body: some View { bodyView }
}

struct EvidenceBadge: View {
    let level: String
    var color: Color {
        switch level.lowercased() {
        case "high": return Color.green
        case "mid": return Color.orange
        default: return Color.gray
        }
    }
    var body: some View {
        Text(level.capitalized).font(.caption2).padding(.horizontal, 8).padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.15)))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 1))
    }
}

// Coach API client placeholder
struct CoachMessage: Codable { let message: String; let context: [String:String]? }
struct CoachReply: Codable { let reply: String; let cards: [CardPayload]? }
struct CardPayload: Codable { let title: String; let body: String; let evidenceLevel: String }

class CoachService {
    func chat(_ text: String) async throws -> CoachReply {
        // TODO: integrate with /v1/coach/chat
        return CoachReply(reply: "占位回复：先做 2 分钟台阶运动。", cards: [
            CardPayload(title: "晚屏幕↑ → 入睡延迟", body: "近 3 天 22:30 后屏幕时长上升，入睡潜伏期延长。", evidenceLevel: "Mid")
        ])
    }
}