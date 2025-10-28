// HabitFlow KMM — V1 Stubs (Kotlin)
package com.habitflow.shared

import kotlinx.serialization.Serializable

@Serializable data class DailyFeatures(
    val date: String,
    val steps: Int? = null,
    val activeMinutes: Int? = null,
    val sleepLatency: Int? = null,
    val sleepDuration: Int? = null,
    val screenAfter2230: Int? = null,
    val caffeineFlag: Boolean? = null,
    val hiIntensityFlag: Boolean? = null,
    val hrv: Int? = null,
    val mood: Int? = null
)

@Serializable data class CausalCard(
    val title: String,
    val evidenceLevel: String,
    val body: String
)

@Serializable data class TinyGoal(
    val domain: String,
    val intentIf: String,
    val intentThen: String,
    val durationMin: Int
)

interface CoachRepository {
    suspend fun chat(message: String, context: Map<String, String> = emptyMap()): CoachReply
}

@Serializable data class CoachReply(
    val reply: String,
    val cards: List<CausalCard> = emptyList()
)