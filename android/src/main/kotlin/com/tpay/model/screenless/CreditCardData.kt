package com.tpay.model.screenless

import com.tpay.sdk.api.screenless.card.CreditCard

data class CreditCardData(
    val creditCard: CreditCard,
    val saveCard: Boolean,
    val domain: String,
    val rocText: String?
)