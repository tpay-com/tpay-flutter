package com.tpay.model

import org.json.JSONObject
import com.tpay.sdk.api.models.PaymentMethod
import com.tpay.sdk.api.models.DigitalWallet
import com.tpay.extension.ValidationException

class PaymentMethods(val methods: List<PaymentMethod>) {
    companion object {
        private const val UNKNOWN_PAYMENT_METHOD_MESSAGE = "Unknown payment method"
        private const val UNKNOWN_DIGITAL_WALLET_MESSAGE = "Unknown digital wallet"
        private const val DEFINE_PAYMENT_METHODS_MESSAGE = "Define payment methods"
        private const val APPLE_PAY = "applePay"
        private const val GOOGLE_PAY = "googlePay"
        private const val PAYPAL = "paypal"
        private const val DIGITAL_WALLETS = "digitalWallets"
        private const val BLIK = "blik"
        private const val CARD = "card"
        private const val TRANSFER = "transfer"
        private const val METHODS_ARRAY = "methods"
        private const val WALLETS_ARRAY = "wallets"

        fun fromJson(json: JSONObject): PaymentMethods {
            val paymentMethodsArray = json.getJSONArray(METHODS_ARRAY)
            val digitalWalletsArray = json.optJSONArray(WALLETS_ARRAY)

            val wallets = digitalWalletsArray?.let { array ->
                (0 until array.length())
                    .map { index -> array.getString(index) }
                    .filter { value -> value != APPLE_PAY }
                    .map { value ->
                        when (value) {
                            GOOGLE_PAY -> DigitalWallet.GOOGLE_PAY
                            else -> throw ValidationException(UNKNOWN_DIGITAL_WALLET_MESSAGE)
                        }
                    }
            } ?: emptyList()

            val paymentMethods = (0 until paymentMethodsArray.length())
                .map { index -> paymentMethodsArray.getString(index) }
                .let { values ->
                    if (wallets.isNotEmpty()) {
                        values + DIGITAL_WALLETS
                    } else {
                        values
                    }
                }
                .map { value ->
                    when (value) {
                        BLIK -> PaymentMethod.Blik
                        TRANSFER -> PaymentMethod.Pbl
                        CARD -> PaymentMethod.Card
                        DIGITAL_WALLETS -> PaymentMethod.DigitalWallets(wallets)
                        else -> throw ValidationException(UNKNOWN_PAYMENT_METHOD_MESSAGE)
                    }
                }

            if (paymentMethods.isEmpty()) {
                throw ValidationException(DEFINE_PAYMENT_METHODS_MESSAGE)
            }

            return PaymentMethods(methods = paymentMethods)
        }
    }
}