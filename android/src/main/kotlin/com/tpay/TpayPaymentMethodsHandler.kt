package com.tpay

import io.flutter.plugin.common.MethodChannel.Result
import com.tpay.sdk.api.screenless.paymentMethods.*

class TpayPaymentMethodsHandler(private val onResult: (GetPaymentMethodsResult) -> Unit) {
    init { GetPaymentMethods().execute(onResult) }
}