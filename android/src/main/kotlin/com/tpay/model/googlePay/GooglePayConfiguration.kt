package com.tpay.model.googlePay

import org.json.JSONObject

data class GooglePayConfiguration(val merchantId: String) {
    companion object {
        private const val MERCHANT_ID = "merchantId"

        fun fromJson(json: JSONObject) = json.run {
            GooglePayConfiguration(merchantId = getString(MERCHANT_ID))
        }
    }
}