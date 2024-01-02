package com.tpay.extension

import org.json.JSONObject
import com.tpay.sdk.api.screenless.blik.AmbiguousAlias

fun AmbiguousAlias.toJson(): String {
    return JSONObject().apply {
        put("name", name)
        put("code", code)
    }.toString()
}