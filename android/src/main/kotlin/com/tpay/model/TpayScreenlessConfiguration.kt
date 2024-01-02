package com.tpay.model

import org.json.JSONObject
import com.tpay.util.*
import com.tpay.sdk.api.models.Environment
import com.tpay.extension.*

data class TpayScreenlessConfiguration(
    val authorization: MerchantAuthorization,
    val certificateConfiguration: CertificateConfiguration,
    val environment: Environment
) : Configuration {
    override fun validate() {
        if (authorization.clientId.isBlank() || authorization.clientSecret.isBlank()) {
            throw ValidationException(ValidationMessages.CREDENTIALS_BLANK)
        }

        ValidationUtil.validatePublicKey(certificateConfiguration.publicKeyHash)
    }

    companion object {
        private const val AUTHORIZATION = "authorization"
        private const val CERTIFICATE_PINNING_CONFIGURATION = "certificatePinningConfiguration"
        private const val ENVIRONMENT = "environment"

        fun fromJson(json: String): TpayScreenlessConfiguration {
            val jsonObject = JSONObject(json)

            return TpayScreenlessConfiguration(
                authorization = MerchantAuthorization.fromJson(
                    jsonObject.getJSONObject(AUTHORIZATION)
                ),
                certificateConfiguration = CertificateConfiguration.fromJson(
                    jsonObject.getJSONObject(CERTIFICATE_PINNING_CONFIGURATION)
                ),
                environment = jsonObject.getString(ENVIRONMENT).toEnvironment()
            )
        }
    }
}