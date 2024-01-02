package com.tpay.extension

import com.tpay.sdk.api.models.transaction.SingleTransaction
import com.tpay.util.ValidationMessages
import com.tpay.extension.ValidationException

fun SingleTransaction.validate() {
    if (amount <= 0) {
        throw ValidationException(ValidationMessages.AMOUNT_NEGATIVE)
    }
    if (description.isBlank()) {
        throw ValidationException(ValidationMessages.DESCRIPTION_BLANK)
    }
}