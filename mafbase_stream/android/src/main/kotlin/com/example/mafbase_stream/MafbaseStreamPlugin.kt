package com.example.mafbase_stream

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.example.mafbase_stream.overlay.OverlayCatalog
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** MafbaseStreamPlugin */
class MafbaseStreamPlugin :
    FlutterPlugin,
    MethodCallHandler,
    ActivityAware,
    PluginRegistry.ActivityResultListener {

    private lateinit var channel: MethodChannel
    private var activityBinding: ActivityPluginBinding? = null
    private var activity: Activity? = null
    private var pendingResult: Result? = null

    companion object {
        private const val REQUEST_OPEN_STREAM = 9001
        private const val REQUEST_OPEN_OVERLAY_PREVIEW = 9002
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mafbase_stream")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result,
    ) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "openStreamScreen" -> openStreamScreen(call, result)
            "openOverlayPreview" -> openOverlayPreview(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        detachActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityBinding = binding
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        detachActivity()
    }

    private fun detachActivity() {
        activityBinding?.removeActivityResultListener(this)
        activityBinding = null
        activity = null
    }

    private fun openStreamScreen(call: MethodCall, result: Result) {
        val act = activity
        if (act == null) {
            result.error("NO_ACTIVITY", "Plugin is not attached to an Activity", null)
            return
        }
        if (pendingResult != null) {
            result.error("ALREADY_OPEN", "Stream screen is already open", null)
            return
        }
        pendingResult = result
        val rawOverlay = call.argument<String>("overlayViewType")
        val tournamentId = call.argument<Number>("tournamentId")?.toInt()
        val table = call.argument<Number>("table")?.toInt()
        Log.d(
            "MafbaseStream",
            "openStreamScreen args: rtmpUrl=${call.argument<String>("rtmpUrl")} overlay=$rawOverlay " +
                "tournamentId=$tournamentId table=$table",
        )
        val intent = Intent(act, StreamActivity::class.java).apply {
            call.argument<String>("rtmpUrl")?.let { putExtra(StreamActivity.EXTRA_RTMP_URL, it) }
            call.argument<String>("streamKey")?.let { putExtra(StreamActivity.EXTRA_STREAM_KEY, it) }
            rawOverlay?.let { putExtra(StreamActivity.EXTRA_OVERLAY_VIEW_TYPE, it) }
            tournamentId?.let { putExtra(StreamActivity.EXTRA_TOURNAMENT_ID, it) }
            table?.let { putExtra(StreamActivity.EXTRA_TABLE, it) }
        }
        act.startActivityForResult(intent, REQUEST_OPEN_STREAM)
    }

    private fun openOverlayPreview(call: MethodCall, result: Result) {
        val act = activity
        if (act == null) {
            result.error("NO_ACTIVITY", "Plugin is not attached to an Activity", null)
            return
        }
        if (pendingResult != null) {
            result.error("ALREADY_OPEN", "Another mafbase_stream screen is already open", null)
            return
        }
        val viewType = call.argument<String>("overlayViewType")
        if (viewType.isNullOrEmpty()) {
            result.error("INVALID_ARGUMENT", "overlayViewType is required", null)
            return
        }
        if (!OverlayCatalog.has(viewType)) {
            result.error(
                "OVERLAY_NOT_FOUND",
                "No overlay registered in plugin catalog for viewType '$viewType'",
                null,
            )
            return
        }
        pendingResult = result
        val tournamentId = call.argument<Number>("tournamentId")?.toInt()
        val table = call.argument<Number>("table")?.toInt()
        val intent = Intent(act, OverlayPreviewActivity::class.java).apply {
            putExtra(OverlayPreviewActivity.EXTRA_OVERLAY_VIEW_TYPE, viewType)
            tournamentId?.let { putExtra(OverlayPreviewActivity.EXTRA_TOURNAMENT_ID, it) }
            table?.let { putExtra(OverlayPreviewActivity.EXTRA_TABLE, it) }
        }
        act.startActivityForResult(intent, REQUEST_OPEN_OVERLAY_PREVIEW)
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
    ): Boolean {
        when (requestCode) {
            REQUEST_OPEN_STREAM -> {
                val result = pendingResult ?: return true
                pendingResult = null
                when (resultCode) {
                    StreamActivity.RESULT_PERMISSIONS_DENIED ->
                        result.error(
                            "PERMISSIONS_DENIED",
                            "Camera or microphone permissions denied",
                            null,
                        )
                    else -> result.success(null)
                }
                return true
            }
            REQUEST_OPEN_OVERLAY_PREVIEW -> {
                val result = pendingResult ?: return true
                pendingResult = null
                result.success(null)
                return true
            }
            else -> return false
        }
    }
}
