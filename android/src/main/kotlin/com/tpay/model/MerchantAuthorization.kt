package com.tpay.model

import org.json.JSONObject

data class MerchantAuthorization(
    val clientId: String,
    val clientSecret: String
) {
    companion object {
        private const val CLIENT_ID = "clientId"
        private const val CLIENT_SECRET = "clientSecret"

        fun fromJson(json: JSONObject): MerchantAuthorization {
            return MerchantAuthorization(
                clientId = json.getString(CLIENT_ID),
                clientSecret = json.getString(CLIENT_SECRET)
            )
        }
    }
}