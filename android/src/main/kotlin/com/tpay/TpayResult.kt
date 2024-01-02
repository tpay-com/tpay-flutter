package com.tpay

sealed class TpayResult {
    data class ValidationError(val message: String) : TpayResult()
    object ConfigurationSuccess : TpayResult()
    data class PaymentCompleted(val transactionId: String?) : TpayResult()
    data class PaymentCancelled(val transactionId: String?) : TpayResult()
    object TokenizationCompleted : TpayResult()
    object TokenizationFailure : TpayResult()
    object ModuleClosed : TpayResult()
    internal data class MethodCallError(val message: String) : TpayResult()
}
