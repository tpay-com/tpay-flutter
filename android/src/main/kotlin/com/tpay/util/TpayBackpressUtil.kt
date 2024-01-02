package com.tpay.util

import com.tpay.sdk.api.models.Presentable
import java.util.ArrayDeque

object TpayBackpressUtil {
    private var sheet: Presentable? = null

    val isModuleVisible: Boolean
        get() = sheet != null

    fun set(sheet: Presentable) {
        this.sheet = sheet
    }

    fun remove() {
        sheet = null
    }

    fun onBackPressed() {
        sheet?.onBackPressed()
    }
}