package com.example.mafbase_stream

import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.os.Build
import android.util.Log
import android.util.Size
import android.view.SurfaceHolder
import kotlin.math.atan

/**
 * Выбор задних камер: основная (1×) и ультраширокая (0.5×), если устройство её
 * экспонирует. Ультраширокая ищется двумя способами:
 *  - отдельный back-камера id с заметно бóльшим горизонтальным FOV (камеры с
 *    другой ориентацией сенсора отбрасываются: смена объектива переиспользует
 *    живой Compositor, чей поворот кадра фиксирован при создании);
 *  - если отдельного id нет (Pixel и другие устройства прячут ультраширокую как
 *    физическую камеру логической) — zoom ratio < 1.0 у основной камеры
 *    (API 30+), тогда переключение делается через CONTROL_ZOOM_RATIO.
 */
internal class CameraSelector(private val manager: CameraManager) {

    val defaultBackCameraId: String?
    val ultraWideCameraId: String?

    /**
     * Zoom ratio, включающий ультраширокий модуль логической камеры. Заполнен
     * только когда отдельного ультраширокого id нет, а CONTROL_ZOOM_RATIO_RANGE
     * основной камеры начинается ниже 1.0.
     */
    val ultraWideZoomRatio: Float?

    val hasUltraWide: Boolean get() = ultraWideCameraId != null || ultraWideZoomRatio != null

    init {
        var defaultId: String? = null
        var ultraWideId: String? = null
        var zoomRatio: Float? = null
        try {
            val backIds = manager.cameraIdList.filter { id ->
                manager.getCameraCharacteristics(id).get(CameraCharacteristics.LENS_FACING) ==
                    CameraCharacteristics.LENS_FACING_BACK
            }
            defaultId = backIds.firstOrNull() ?: manager.cameraIdList.firstOrNull()
            if (defaultId != null && backIds.size > 1) {
                val defaultCharacteristics = manager.getCameraCharacteristics(defaultId)
                val defaultFov = horizontalFov(defaultCharacteristics)
                val defaultOrientation =
                    defaultCharacteristics.get(CameraCharacteristics.SENSOR_ORIENTATION)
                if (defaultFov != null) {
                    ultraWideId = backIds
                        .filter { it != defaultId }
                        .filter { id ->
                            manager.getCameraCharacteristics(id)
                                .get(CameraCharacteristics.SENSOR_ORIENTATION) == defaultOrientation
                        }
                        .mapNotNull { id ->
                            horizontalFov(manager.getCameraCharacteristics(id))?.let { id to it }
                        }
                        .filter { (_, fov) -> fov > defaultFov * ULTRA_WIDE_FOV_FACTOR }
                        .maxByOrNull { (_, fov) -> fov }
                        ?.first
                }
            }
            if (defaultId != null && ultraWideId == null &&
                Build.VERSION.SDK_INT >= Build.VERSION_CODES.R
            ) {
                val range = manager.getCameraCharacteristics(defaultId)
                    .get(CameraCharacteristics.CONTROL_ZOOM_RATIO_RANGE)
                if (range != null && range.lower < 1f) {
                    zoomRatio = range.lower
                }
            }
        } catch (e: Exception) {
            Log.w(TAG, "camera discovery failed", e)
        }
        defaultBackCameraId = defaultId
        ultraWideCameraId = ultraWideId
        ultraWideZoomRatio = zoomRatio
        Log.d(
            TAG,
            "cameras: default=$defaultBackCameraId ultraWide=$ultraWideCameraId " +
                "uwZoomRatio=$ultraWideZoomRatio",
        )
    }

    /** Поддерживает ли камера [size] как output-размер кадра. */
    fun supportsSize(cameraId: String, size: Size): Boolean = try {
        manager.getCameraCharacteristics(cameraId)
            .get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)
            ?.getOutputSizes(SurfaceHolder::class.java)
            ?.contains(size) == true
    } catch (e: Exception) {
        Log.w(TAG, "supportsSize failed for camera $cameraId", e)
        false
    }

    private fun horizontalFov(characteristics: CameraCharacteristics): Double? {
        val focal = characteristics.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS)
            ?.minOrNull() ?: return null
        val sensorWidth = characteristics.get(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE)
            ?.width ?: return null
        if (focal <= 0f || sensorWidth <= 0f) return null
        return 2.0 * atan(sensorWidth / (2.0 * focal))
    }

    private companion object {
        const val TAG = "CameraSelector"
        const val ULTRA_WIDE_FOV_FACTOR = 1.25
    }
}
