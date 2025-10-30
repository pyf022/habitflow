import SwiftUI
import UIKit

struct MainTabView: View {
    @State private var selection: Tab = .today

    var body: some View {
        TabView(selection: $selection) {
            TodayView()
                .tabItem { Label(Tab.today.title, systemImage: Tab.today.systemImage) }
                .tag(Tab.today)

            CoachView()
                .tabItem { Label(Tab.coach.title, systemImage: Tab.coach.systemImage) }
                .tag(Tab.coach)

            LogView()
                .tabItem { Label(Tab.log.title, systemImage: Tab.log.systemImage) }
                .tag(Tab.log)

            WeeklyView()
                .tabItem { Label(Tab.weekly.title, systemImage: Tab.weekly.systemImage) }
                .tag(Tab.weekly)

            ProfileView()
                .tabItem { Label(Tab.profile.title, systemImage: Tab.profile.systemImage) }
                .tag(Tab.profile)
        }
        .accentColor(HabitFlowTheme.ColorPalette.primary)
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
}

extension MainTabView {
    enum Tab: Hashable {
        case today
        case coach
        case log
        case weekly
        case profile

        var title: String {
            switch self {
            case .today:
                return "今日"
            case .coach:
                return "教练"
            case .log:
                return "记录"
            case .weekly:
                return "周报"
            case .profile:
                return "我"
            }
        }

        var systemImage: String {
            switch self {
            case .today:
                return "sparkles"
            case .coach:
                return "message.circle"
            case .log:
                return "chart.bar.doc.horizontal"
            case .weekly:
                return "calendar"
            case .profile:
                return "person.crop.circle"
            }
        }
    }
}
