package com.habitflow.backend.domain.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum HabitButtonKind {
    PRIMARY("PRIMARY"),
    GHOST("GHOST"),
    TERTIARY("TERTIARY"),
    LINK("LINK");

    @EnumValue
    private final String value;

    @JsonValue
    public String getValue() {
        return value;
    }
}
