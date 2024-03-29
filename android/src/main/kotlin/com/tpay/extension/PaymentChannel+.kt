package com.tpay.extension

import com.tpay.sdk.api.screenless.channelMethods.*
import org.json.JSONArray
import org.json.JSONObject

fun List<PaymentChannel>.toJsonArray(): JSONArray {
  return JSONArray().apply {
    forEach { channel ->
      put(channel.toJsonObject())
    }
  }
}

fun PaymentChannel.toJsonObject(): JSONObject {
  return JSONObject().apply {
    put("id", id)
    put("name", name)
    put("imageUrl", imageUrl)
    put("constraints", constraints.toJsonArray())
  }
}