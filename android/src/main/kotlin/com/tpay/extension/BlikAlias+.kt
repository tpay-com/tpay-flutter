package com.tpay.extension

import com.tpay.sdk.api.models.BlikAlias
import org.json.JSONObject

private const val VALUE = "value"
private const val LABEL = "label"
private const val IS_REGISTERED = "isRegistered"

fun JSONObject.getBlikAlias(): BlikAlias {
    val value = getString(VALUE)
    val label = getString(LABEL)
    return if (getBoolean(IS_REGISTERED)) {
        BlikAlias.Registered(value, label)
    } else {
        BlikAlias.NotRegistered(value, label)
    }
}