package com.tpay

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.android.FlutterFragmentActivity

class TpayPlugin: FlutterPlugin, ActivityAware {
    private var tpayMethodCallHandler: TpayMethodCallHandler? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        tpayMethodCallHandler = TpayMethodCallHandler(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        tpayMethodCallHandler?.dispose()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        tpayMethodCallHandler?.run {
            activity = binding.activity as FlutterFragmentActivity
            binding.removeActivityResultListener(this)
            binding.addActivityResultListener(this)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        tpayMethodCallHandler?.activity = null
        tpayMethodCallHandler?.googlePayUtil = null
    }
}