import SwiftUI

extension HabitBadge.Style {
    static func from(_ style: BadgeStyleResponse) -> HabitBadge.Style {
        switch style {
        case .primary:
            return .primary
        case .outline:
            return .outline
        case .warning:
            return .warning
        }
    }
}

extension HabitButtonKind {
    init(apiKind: ButtonKindResponse) {
        switch apiKind {
        case .primary:
            self = .primary
        case .ghost:
            self = .ghost
        case .tertiary:
            self = .tertiary
        case .link:
            self = .link
        }
    }
}

extension CoachMessage.Role {
    init(apiRole: CoachRoleResponse) {
        switch apiRole {
        case .ai:
            self = .ai
        case .user:
            self = .user
        }
    }
}

extension HabitActionButton {
    init(response: ActionButtonResponse) {
        self.init(title: response.title, kind: HabitButtonKind(apiKind: response.kind))
    }
}

extension HabitQuickAction {
    init(response: HabitQuickActionResponse) {
        self.init(domain: response.domain, title: response.title, caption: response.caption)
    }
}

extension CoachMessage {
    init(response: CoachMessageResponse) {
        self.init(role: CoachMessage.Role(apiRole: response.role), text: response.text)
    }
}

extension HabitInsight {
    init(response: HabitInsightResponse) {
        self.init(
            title: response.title,
            evidenceLevel: response.evidenceLevel,
            body: response.body,
            actions: response.actions?.map(HabitActionButton.init(response:)) ?? []
        )
    }
}

extension MicroHabitPlan {
    init(response: MicroHabitPlanResponse) {
        self.init(
            title: response.title,
            summary: response.summary,
            metadata: response.metadata ?? [],
            actions: response.actions?.map(HabitActionButton.init(response:)) ?? []
        )
    }
}

extension HabitLogMetric {
    init(response: HabitLogMetricResponse) {
        self.init(label: response.label, value: response.value, detail: response.detail)
    }
}

extension HabitTimelineEntry {
    init(response: HabitTimelineEntryResponse) {
        self.init(time: response.time, title: response.title, meta: response.meta, detail: response.detail)
    }
}

extension WeeklyInsight {
    init(response: WeeklyInsightResponse) {
        self.init(title: response.title, detail: response.detail, cta: response.cta)
    }
}

extension PlanRowView.MetadataItem {
    init(response: PlanMetadataItemResponse) {
        self.init(label: response.label, value: response.value)
    }
}

extension WeeklyPlanItem {
    init(response: WeeklyPlanItemResponse) {
        self.init(
            title: response.title,
            metadata: response.metadata?.map(PlanRowView.MetadataItem.init(response:)) ?? [],
            buttonTitle: response.buttonTitle,
            buttonKind: HabitButtonKind(apiKind: response.buttonKind)
        )
    }
}

extension CoachRecommendation {
    init(response: CoachRecommendationResponse) {
        self.init(
            evidenceTag: response.evidenceTag,
            dataWindow: response.dataWindow,
            summary: response.summary,
            actions: response.actions?.map(HabitActionButton.init(response:)) ?? []
        )
    }
}

extension CoachComposerModel {
    init(response: CoachComposerResponse) {
        self.init(
            prompt: response.prompt,
            placeholder: response.placeholder,
            submitTitle: response.submitTitle,
            buttonKind: HabitButtonKind(apiKind: response.buttonKind)
        )
    }
}

extension ManualCaptureModel {
    init(response: ManualCaptureGuideResponse) {
        self.init(
            headline: response.headline,
            body: response.body,
            buttonTitle: response.buttonTitle,
            buttonKind: HabitButtonKind(apiKind: response.buttonKind),
            badgeText: response.badgeText,
            badgeStyle: HabitBadge.Style.from(response.badgeStyle)
        )
    }
}

extension WeeklySummaryModel {
    init(response: WeeklySummaryResponse) {
        self.init(
            progress: response.progressRatio,
            trendLabel: response.trendLabel,
            trendValue: response.trendValue,
            summaryLines: response.summaryLines ?? []
        )
    }
}

extension ProfileIdentityModel {
    init(response: ProfileIdentityResponse) {
        self.init(
            initials: response.initials,
            displayName: response.displayName,
            email: response.email,
            lastSyncLabel: response.lastSyncLabel,
            experimentTag: response.experimentTag
        )
    }
}

extension ProfileDataStrategyModel {
    init(response: ProfileDataStrategyResponse) {
        self.init(
            summary: response.summary,
            actions: response.actions?.map(HabitActionButton.init(response:)) ?? []
        )
    }
}

extension DataAuthorizationItem {
    init(response: DataAuthorizationItemResponse) {
        self.init(
            scope: response.scope,
            status: response.status,
            actionTitle: response.actionTitle,
            kind: HabitButtonKind(apiKind: response.buttonKind)
        )
    }
}

extension SettingPreference {
    init(response: SettingPreferenceResponse) {
        self.init(title: response.title, isOn: response.enabled)
    }
}

extension ProfileLink {
    init(response: ProfileLinkResponse) {
        self.init(title: response.title, icon: response.icon)
    }
}
