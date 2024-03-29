package com.tpay.extension

import com.tpay.sdk.api.screenless.channelMethods.*
import com.tpay.model.screenless.PaymentConstraintType
import org.json.JSONObject
import org.json.JSONArray

fun List<PaymentConstraint>.toJsonArray(): JSONArray {
  return JSONArray().apply {
    forEach { constraint -> put(constraint.toJsonObject()) }
  }
}

fun PaymentConstraint.toJsonObject(): JSONObject {
  return JSONObject().apply {
    when (this@toJsonObject) {
      is PaymentConstraint.Amount -> {
        put("type", PaymentConstraintType.AMOUNT)
        put("minimum", minimum)
        put("maximum", maximum)
      }
    }
  }
}