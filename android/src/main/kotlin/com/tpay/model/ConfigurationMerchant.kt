package com.tpay.model

import org.json.JSONObject
import com.tpay.sdk.api.models.PaymentMethod
import com.tpay.extension.ValidationException
import com.tpay.util.*
import com.tpay.sdk.api.models.Environment
import com.tpay.extension.*

data class ConfigurationMerchant(
    val authorization: MerchantAuthorization,
    val environment: Environment,
    val certificateConfiguration: CertificateConfiguration,
    val walletConfiguration: WalletConfiguration?
) {
    companion object {
        private const val AUTHORIZATION = "authorization"
        private const val ENVIRONMENT = "environment"
        private const val CERTIFICATE_PINNING_CONFIGURATION = "certificatePinningConfiguration"
        private const val WALLET_CONFIGURATION = "walletConfiguration"

        fun fromJson(json: JSONObject): ConfigurationMerchant = json.run {
            ConfigurationMerchant(
                authorization = MerchantAuthorization.fromJson(getJSONObject(AUTHORIZATION)),
                environment = getString(ENVIRONMENT).toEnvironment(),
                certificateConfiguration = CertificateConfiguration.fromJson(
                    getJSONObject(CERTIFICATE_PINNING_CONFIGURATION)
                ),
                walletConfiguration = optJSONObject(WALLET_CONFIGURATION)?.run(WalletConfiguration::fromJson)
            )
        }
    }
}