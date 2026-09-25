package com.example.mafbase_stream.pipeline

import kotlin.test.Test
import kotlin.test.assertEquals

internal class RetryBackoffTest {

    @Test
    fun cameraBackoff_doublesFromOneSecondAndCapsAtTen() {
        val backoff = RetryBackoff(baseMs = 1_000L, capMs = 10_000L)

        val delays = List(6) { backoff.nextDelayMs() }

        assertEquals(listOf(1_000L, 2_000L, 4_000L, 8_000L, 10_000L, 10_000L), delays)
        assertEquals(6, backoff.attempt)
    }

    @Test
    fun streamBackoff_doublesFromTwoSecondsAndCapsAtFifteen() {
        val backoff = RetryBackoff(baseMs = 2_000L, capMs = 15_000L)

        val delays = List(5) { backoff.nextDelayMs() }

        assertEquals(listOf(2_000L, 4_000L, 8_000L, 15_000L, 15_000L), delays)
    }

    @Test
    fun reset_startsFromBaseAgain() {
        val backoff = RetryBackoff(baseMs = 1_000L, capMs = 10_000L)
        repeat(3) { backoff.nextDelayMs() }

        backoff.reset()

        assertEquals(0, backoff.attempt)
        assertEquals(1_000L, backoff.nextDelayMs())
    }

    @Test
    fun nextDelay_staysAtCapAfterManyAttempts() {
        val backoff = RetryBackoff(baseMs = 1_000L, capMs = 10_000L)

        repeat(100) { backoff.nextDelayMs() }

        assertEquals(10_000L, backoff.nextDelayMs())
    }
}
