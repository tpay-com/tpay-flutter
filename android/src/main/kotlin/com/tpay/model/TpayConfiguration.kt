package com.tpay.model

import org.json.JSONObject
import com.tpay.sdk.api.models.PaymentMethod
import com.tpay.extension.ValidationException
import com.tpay.util.*
import com.tpay.sdk.api.models.Environment
import com.tpay.extension.*

data class TpayConfiguration(
    val merchant: ConfigurationMerchant,
    val merchantDetails: MerchantDetails,
    val languages: Languages,
    val paymentMethods: PaymentMethods,
) : Configuration {
    override fun validate() {
        val allLanguages = (languages.supportedLanguages + languages.preferredLanguage).distinct()
        val displayNameLanguages = merchantDetails.displayNames.map { localization -> localization.language }
        val merchantHeadquartersLanguages = merchantDetails.merchantHeadquarters.map { localization -> localization.language }
        val regulationLanguages = merchantDetails.regulations.map { localization -> localization.language }
        if (
            !displayNameLanguages.containsAll(allLanguages) ||
            !merchantHeadquartersLanguages.containsAll(allLanguages) ||
            !regulationLanguages.containsAll(allLanguages)
        ) {
            throw ValidationException(ValidationMessages.PROVIDE_LOCALIZATION_MESSAGE)
        }

        if (merchant.authorization.clientId.isBlank() || merchant.authorization.clientSecret.isBlank()) {
            throw ValidationException(ValidationMessages.CREDENTIALS_BLANK)
        }
    }

    companion object {
        private const val MERCHANT = "merchant"
        private const val MERCHANT_DETAILS = "merchantDetails"
        private const val LANGUAGES = "languages"
        private const val PAYMENT_METHODS = "paymentMethods"

        fun fromJson(json: String): TpayConfiguration = JSONObject(json).run {
            TpayConfiguration(
                merchant = ConfigurationMerchant.fromJson(getJSONObject(MERCHANT)),
                merchantDetails = MerchantDetails.fromJson(getJSONObject(MERCHANT_DETAILS)),
                languages = Languages.fromJson(getJSONObject(LANGUAGES)),
                paymentMethods = PaymentMethods.fromJson(getJSONObject(PAYMENT_METHODS)),
            )
        }
    }
}

