package com.tpay.extension

import io.flutter.plugin.common.MethodCall

val MethodCall.stringArgument: String?
    get() = arguments as? String