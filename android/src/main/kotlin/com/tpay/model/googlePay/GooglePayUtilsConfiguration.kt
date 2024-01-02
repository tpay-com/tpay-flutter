package com.tpay.model.googlePay

import com.tpay.sdk.api.screenless.googlePay.GooglePayEnvironment
import org.json.JSONObject
import com.tpay.extension.ValidationException

data class GooglePayUtilsConfiguration(
    val price: Double,
    val merchantName: String,
    val merchantId: String,
    val environment: GooglePayEnvironment,
    val customRequestCode: Int? = null
) {
    fun validate() {
        if (price <= 0) {
            throw ValidationException(PRICE_INVALID)
        }
        if (merchantName.isBlank()) {
            throw ValidationException(MERCHANT_NAME_BLANK)
        }
        if (merchantId.isBlank()) {
            throw ValidationException(MERCHANT_ID_BLANK)
        }
        customRequestCode?.run {
            if (this < 0) {
                throw ValidationException(CUSTOM_REQUEST_CODE_NEGATIVE)
            }
        }
    }

    companion object {
        private const val PRICE = "price"
        private const val MERCHANT_NAME = "merchantName"
        private const val MERCHANT_ID = "merchantId"
        private const val ENVIRONMENT = "environment"
        private const val CUSTOM_REQUEST_CODE = "customRequestCode"
        private const val ENVIRONMENT_PRODUCTION = "production"
        private const val ENVIRONMENT_TEST = "test"
        private const val UNKNOWN_ENVIRONMENT_MESSAGE = "Unknown Google Pay environment"
        private const val PRICE_INVALID = "Price is invalid"
        private const val MERCHANT_NAME_BLANK = "Merchant name cannot be blank"
        private const val MERCHANT_ID_BLANK = "Merchant id cannot be blank"
        private const val CUSTOM_REQUEST_CODE_NEGATIVE = "Custom request code cannot be negative"

        fun fromJson(json: String): GooglePayUtilsConfiguration {
            val rootJson = JSONObject(json)

            return GooglePayUtilsConfiguration(
                price = rootJson.getDouble(PRICE),
                merchantName = rootJson.getString(MERCHANT_NAME),
                merchantId = rootJson.getString(MERCHANT_ID),
                environment = rootJson.getString(ENVIRONMENT).let { environment ->
                    when (environment) {
                        ENVIRONMENT_PRODUCTION -> GooglePayEnvironment.PRODUCTION
                        ENVIRONMENT_TEST -> GooglePayEnvironment.TEST
                        else -> throw IllegalArgumentException(UNKNOWN_ENVIRONMENT_MESSAGE)
                    }
                },
                customRequestCode = rootJson.optInt(CUSTOM_REQUEST_CODE)
            )
        }
    }
}