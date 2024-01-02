package com.tpay

import com.tpay.sdk.api.screenless.blik.AmbiguousAlias

sealed class TpayScreenlessResult {
    data class Paid(val transactionId: String) : TpayScreenlessResult()
    data class PaymentCreated(
        val transactionId: String,
        val paymentUrl: String?
    ) : TpayScreenlessResult()
    data class ConfiguredPaymentFailed(
        val transactionId: String,
        val errorMessage: String?
    ) : TpayScreenlessResult()
    data class BlikAmbiguousAlias(
        val transactionId: String,
        val ambiguousAliases: List<AmbiguousAlias>
    ) : TpayScreenlessResult()
    data class Error(val errorMessage: String?) : TpayScreenlessResult()
    data class ValidationError(val message: String) : TpayScreenlessResult()
    data class MethodCallError(val message: String) : TpayScreenlessResult()
}