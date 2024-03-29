package com.tpay.model

import com.tpay.model.googlePay.GooglePayConfiguration
import org.json.JSONObject

data class WalletConfiguration(val googlePay: GooglePayConfiguration?) {
    companion object {
        private const val GOOGLE_PAY = "googlePay"

        fun fromJson(json: JSONObject): WalletConfiguration = json.run {
            WalletConfiguration(googlePay = optJSONObject(GOOGLE_PAY)?.run(GooglePayConfiguration::fromJson))
        }
    }
}