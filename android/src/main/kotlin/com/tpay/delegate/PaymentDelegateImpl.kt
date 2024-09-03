package com.tpay.delegate

import com.tpay.sdk.api.payment.PaymentDelegate
import io.flutter.plugin.common.MethodChannel.Result
import com.tpay.sdk.api.models.ObservablePayment
import com.tpay.TpayResult
import com.tpay.util.TpayBackpressUtil

class PaymentDelegateImpl(
    private val sheet: ObservablePayment,
    private val onResult: (TpayResult) -> Unit
) : PaymentDelegate {
    override fun onPaymentCreated(transactionId: String?) {
        onResult(TpayResult.PaymentCreated(transactionId))
    }

    override fun onPaymentCompleted(transactionId: String?) {
        onResult(TpayResult.PaymentCompleted(transactionId))
        remove()
    }

    override fun onPaymentCancelled(transactionId: String?) {
        onResult(TpayResult.PaymentCancelled(transactionId))
        remove()
    }

    override fun onModuleClosed() {
        onResult(TpayResult.ModuleClosed)
        remove()
    }

    private fun remove() {
        sheet.removeObserver()
        TpayBackpressUtil.remove()
    }
}