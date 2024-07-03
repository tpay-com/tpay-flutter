package com.tpay

import com.tpay.model.screenless.*
import com.tpay.sdk.api.screenless.blik.*
import com.tpay.sdk.api.screenless.transfer.*
import com.tpay.sdk.api.screenless.card.*
import com.tpay.sdk.api.screenless.googlePay.*
import com.tpay.sdk.api.screenless.pekaoInstallment.*
import com.tpay.sdk.api.screenless.payPo.*
import com.tpay.sdk.api.screenless.PaymentDetails
import com.tpay.sdk.api.screenless.LongPollingConfig
import com.tpay.sdk.api.screenless.TransactionState

class TpayScreenlessPaymentHandler(
    private val payment: ScreenlessPayment,
    private val onResult: (TpayScreenlessResult) -> Unit
) {
    init {
        payment.run {
            val paymentDetails = PaymentDetails(amount, description, hiddenDescription, language)

            when (this) {
                is BLIKScreenlessPayment -> {
                    BLIKPayment.Builder()
                        .apply {
                            code?.let { setBLIKCode(code) }
                            alias?.let { setBLIKAlias(alias) }
                            if (code != null && alias != null) {
                                setBLIKCodeAndRegisterAlias(code, alias)
                            }
                            setPayer(payer)
                            setPaymentDetails(paymentDetails)
                            setCallbacks(redirects, notifications)
                        }
                        .build()
                        .execute { createResult ->
                            onResult(TpayScreenlessResultHandler.handleBLIKCreateResult(createResult))
                        }
                }
                is TransferScreenlessPayment -> {
                    TransferPayment.Builder()
                        .apply {
                            setChannelId(channelId)
                            setPayer(payer)
                            setPaymentDetails(paymentDetails)
                            setCallbacks(redirects, notifications)
                        }
                        .build()
                        .execute { createResult ->
                            onResult(TpayScreenlessResultHandler.handleTransferCreateResult(createResult))
                        }
                }
                is RatyPekaoScreenlessPayment -> {
                    PekaoInstallmentPayment.Builder()
                        .apply {
                            setChannelId(channelId)
                            setPayer(payer)
                            setPaymentDetails(paymentDetails)
                            setCallbacks(redirects, notifications)
                        }
                        .build()
                        .execute { createResult ->
                            onResult(TpayScreenlessResultHandler.handleRatyPekaoCreateResult(createResult))
                        }
                }
                is PayPoScreenlessPayment -> {
                    PayPoPayment.Builder()
                        .apply {
                            setPayer(payer)
                            setPaymentDetails(paymentDetails)
                            setCallbacks(redirects, notifications)
                        }
                        .build()
                        .execute { createResult ->
                            onResult(TpayScreenlessResultHandler.handlePayPoCreateResult(createResult))
                        }
                }
                is CreditCardScreenlessPayment -> {
                    CreditCardPayment.Builder()
                        .apply {
                            creditCardData?.run {
                                setCreditCard(creditCard, domain, saveCard, rocText)
                            }
                            cardToken?.let { setCreditCardToken(cardToken) }
                            recursive?.let { setRecursive(recursive) }
                            setPayer(payer)
                            setPaymentDetails(paymentDetails)
                            setCallbacks(redirects, notifications)
                        }
                        .build()
                        .execute { createResult ->
                            onResult(TpayScreenlessResultHandler.handleCreditCardCreateResult(createResult))
                        }
                }
                is GooglePayScreenlessPayment -> {
                    GooglePayPayment.Builder()
                        .apply {
                            setGooglePayToken(token)
                            setPayer(payer)
                            setPaymentDetails(paymentDetails)
                            setCallbacks(redirects, notifications)
                        }
                        .build()
                        .execute { createResult ->
                            onResult(TpayScreenlessResultHandler.handleGooglePayCreateResult(createResult))
                        }
                }
            }
        }
    }
}