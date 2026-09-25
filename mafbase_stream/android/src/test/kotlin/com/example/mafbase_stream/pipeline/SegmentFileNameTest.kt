package com.example.mafbase_stream.pipeline

import kotlin.test.Test
import kotlin.test.assertEquals

internal class SegmentFileNameTest {

    @Test
    fun segmented_appendsPartIndex() {
        assertEquals(
            "mafbase_stream_20260924_101500_part3.mp4",
            segmentFileName("20260924_101500", index = 3, segmented = true),
        )
    }

    @Test
    fun single_hasNoPartSuffix() {
        assertEquals(
            "mafbase_stream_20260924_101500.mp4",
            segmentFileName("20260924_101500", index = 1, segmented = false),
        )
    }
}
