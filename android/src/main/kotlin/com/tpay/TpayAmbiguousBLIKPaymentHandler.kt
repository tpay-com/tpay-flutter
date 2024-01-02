package com.tpay

import com.tpay.model.screenless.*
import com.tpay.sdk.api.screenless.blik.*

class TpayAmbiguousBLIKPaymentHandler(
    private val ambiguousBLIKPayment: AmbiguousBLIKPayment,
    private val onResult: (TpayScreenlessResult) -> Unit
) {
    init {
        ambiguousBLIKPayment.run {
            BLIKAmbiguousAliasPayment.from(
                transactionId = transactionId,
                blikAlias = blikAlias,
                ambiguousAlias = ambiguousBlikAlias.toAmbiguousAlias()
            ).execute { createResult ->
                onResult(TpayScreenlessResultHandler.handleBLIKCreateResult(createResult))
            }
        }
    }
}