package com.tpay.extension

import com.tpay.sdk.api.screenless.channelMethods.*
import org.json.JSONObject
import org.json.JSONArray

fun List<PaymentGroup>.toJsonArray(): JSONArray {
  return JSONArray().apply {
    forEach { group ->
      put(group.toJsonObject())
    }
  }
}

fun PaymentGroup.toJsonObject(): JSONObject {
  return JSONObject().apply {
    put("id", id)
    put("name", name)
    put("imageUrl", imageUrl)
  }
}