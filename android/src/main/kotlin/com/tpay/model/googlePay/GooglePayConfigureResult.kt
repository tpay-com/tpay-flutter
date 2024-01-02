package com.tpay.model.googlePay

sealed class GooglePayConfigureResult {
    object Success : GooglePayConfigureResult()
    data class Error(val errorMessage: String?) : GooglePayConfigureResult()
}