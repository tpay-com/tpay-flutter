package com.tpay.util

import com.tpay.model.*
import com.tpay.sdk.api.tpayModule.TpayModule
import com.tpay.sdk.api.providers.*
import com.tpay.sdk.api.models.*
import com.tpay.sdk.api.models.merchant.*
import com.tpay.sdk.api.models.transaction.SingleTransaction
import com.tpay.model.Configuration

object TpayUtil {
    private const val EMPTY_MERCHANT_ID = "EMPTY_ID"

    fun configure(configuration: Configuration) {
        when (configuration) {
            is TpayConfiguration -> configureStandard(configuration)
        }
    }

    private fun configureStandard(configuration: TpayConfiguration) {
        configuration.run {
            merchant.walletConfiguration?.googlePay?.merchantId?.run {
                TpayModule.configure(GooglePayConfiguration(this))
            }

            TpayModule
                .configure(object : SSLCertificatesProvider {
                    override var apiConfiguration: CertificatePinningConfiguration = CertificatePinningConfiguration(
                        publicKeyHash = merchant.certificateConfiguration.publicKeyHash
                    )
                })
                .configure(merchant.environment)
                .configure(paymentMethods.methods)
                .configure(languages.preferredLanguage, languages.supportedLanguages)
                .configure(Compatibility.FLUTTER)
                .configure(object : MerchantDetailsProvider {
                    override fun merchantDisplayName(language: Language): String {
                        return merchantDetails.displayNames
                            .first { localization -> localization.language == language }
                            .value
                    }

                    override fun merchantCity(language: Language): String? {
                        return merchantDetails.merchantHeadquarters
                            .first { localization -> localization.language == language }
                            .value
                    }

                    override fun regulationsLink(language: Language): String {
                        return merchantDetails.regulations
                            .first { localization -> localization.language == language }
                            .value
                    }
                })
                .configure(
                    Merchant(
                        authorization = Merchant.Authorization(
                            merchant.authorization.clientId,
                            merchant.authorization.clientSecret
                        )
                    )
                )
        }
    }
}