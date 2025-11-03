package com.habitflow.backend.domain.payload;

import com.habitflow.backend.domain.enums.HabitButtonKind;
import lombok.Data;

@Data
public class ActionButtonPayload {
    private String title;
    private HabitButtonKind kind;
}
