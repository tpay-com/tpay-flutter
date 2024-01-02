package com.tpay.model.screenless

import com.tpay.sdk.api.models.BlikAlias
import org.json.JSONObject
import com.tpay.sdk.api.screenless.blik.*
import com.tpay.extension.*

data class AmbiguousBLIKPayment(
    val transactionId: String,
    val blikAlias: BlikAlias,
    val ambiguousBlikAlias: AmbiguousBLIKAlias
) {
    companion object {
        private const val TRANSACTION_ID = "transactionId"
        private const val BLIK_ALIAS = "blikAlias"
        private const val AMBIGUOUS_ALIAS = "ambiguousAlias"

        fun fromJson(json: String): AmbiguousBLIKPayment = JSONObject(json).run {
            AmbiguousBLIKPayment(
                transactionId = getString(TRANSACTION_ID),
                blikAlias = getJSONObject(BLIK_ALIAS).run { getBlikAlias() },
                ambiguousBlikAlias = AmbiguousBLIKAlias.fromJson(getJSONObject(AMBIGUOUS_ALIAS))
            )
        }
    }
}