package com.tpay.delegate

import com.tpay.sdk.api.addCard.*
import com.tpay.TpayResult
import com.tpay.util.TpayBackpressUtil

class AddCardDelegateImpl(
    private val sheet: AddCard.Sheet,
    private val onResult: (TpayResult) -> Unit
) : AddCardDelegate {
    override fun onAddCardSuccess(tokenizationId: String?) {
        onResult(TpayResult.TokenizationCompleted)
        remove()
    }

    override fun onAddCardFailure() {
        onResult(TpayResult.TokenizationFailure)
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