-- HabitFlow prototype relational schema.
-- Aligns with MyBatis-Plus entities under com.habitflow.backend.domain.entity.

CREATE TABLE IF NOT EXISTS screen_context (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    screen_code VARCHAR(32) NOT NULL,
    status_bar_time VARCHAR(32),
    timestamp_label VARCHAR(64),
    title_text VARCHAR(128),
    subtitle_text VARCHAR(255),
    goal_chip VARCHAR(255),
    badge_text VARCHAR(128),
    badge_style VARCHAR(32),
    INDEX idx_screen_context_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS micro_habit_plan (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    summary TEXT,
    metadata JSON,
    actions JSON,
    INDEX idx_micro_habit_plan_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS habit_insight (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    evidence_level VARCHAR(64),
    body TEXT,
    actions JSON,
    INDEX idx_habit_insight_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS habit_quick_action (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    domain VARCHAR(64),
    title VARCHAR(255) NOT NULL,
    caption TEXT,
    order_index INT,
    INDEX idx_habit_quick_action_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS habit_timeline_entry (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    time VARCHAR(32),
    title VARCHAR(255) NOT NULL,
    meta VARCHAR(255),
    detail TEXT,
    order_index INT,
    INDEX idx_habit_timeline_entry_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS habit_log_metric (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    label VARCHAR(128) NOT NULL,
    value VARCHAR(128),
    detail TEXT,
    order_index INT,
    INDEX idx_habit_log_metric_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS manual_capture_guide (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    headline VARCHAR(255) NOT NULL,
    body TEXT,
    button_title VARCHAR(128),
    button_kind VARCHAR(32),
    badge_text VARCHAR(128),
    badge_style VARCHAR(32),
    INDEX idx_manual_capture_guide_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS weekly_summary (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    progress_ratio DOUBLE,
    trend_label VARCHAR(128),
    trend_value VARCHAR(128),
    summary_lines JSON,
    INDEX idx_weekly_summary_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS weekly_insight (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    detail TEXT,
    cta VARCHAR(255),
    order_index INT,
    INDEX idx_weekly_insight_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS weekly_plan_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    metadata JSON,
    button_title VARCHAR(128),
    button_kind VARCHAR(32),
    order_index INT,
    INDEX idx_weekly_plan_item_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS coach_message (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    role VARCHAR(32) NOT NULL,
    text TEXT,
    order_index INT,
    INDEX idx_coach_message_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS coach_recommendation (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    evidence_tag VARCHAR(128),
    data_window VARCHAR(64),
    summary TEXT,
    actions JSON,
    closing_hint VARCHAR(255),
    INDEX idx_coach_recommendation_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS coach_composer_guide (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    prompt TEXT,
    placeholder VARCHAR(255),
    submit_title VARCHAR(128),
    button_kind VARCHAR(32),
    INDEX idx_coach_composer_guide_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS profile_identity (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    initials VARCHAR(16),
    display_name VARCHAR(128),
    email VARCHAR(255),
    last_sync_label VARCHAR(128),
    experiment_tag VARCHAR(64),
    INDEX idx_profile_identity_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS profile_link (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    icon VARCHAR(128),
    order_index INT,
    INDEX idx_profile_link_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS profile_data_strategy (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    summary TEXT,
    actions JSON,
    INDEX idx_profile_data_strategy_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS data_authorization_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    scope VARCHAR(255),
    status VARCHAR(64),
    action_title VARCHAR(128),
    button_kind VARCHAR(32),
    order_index INT,
    INDEX idx_data_authorization_item_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS setting_preference (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    enabled TINYINT(1),
    order_index INT,
    INDEX idx_setting_preference_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
