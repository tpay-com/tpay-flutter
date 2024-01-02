package com.tpay.extension

import com.tpay.sdk.api.cardTokenPayment.CardTokenTransaction
import com.tpay.util.ValidationMessages

fun CardTokenTransaction.validate() {
    if (amount <= 0) {
        throw ValidationException(ValidationMessages.AMOUNT_NEGATIVE)
    }
    if (description.isBlank()) {
        throw ValidationException(ValidationMessages.DESCRIPTION_BLANK)
    }
    if (cardToken.isBlank()) {
        throw ValidationException(ValidationMessages.CARD_TOKEN_BLANK)
    }
    if (payer.name.isBlank() || payer.email.isBlank()) {
        throw ValidationException(ValidationMessages.PAYER_REQUIRED_TOKEN_PAYMENT)
    }
}