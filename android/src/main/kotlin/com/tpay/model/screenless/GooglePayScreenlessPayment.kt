package com.tpay.model.screenless

import com.tpay.util.ValidationMessages
import com.tpay.extension.*

class GooglePayScreenlessPayment(json: String) : ScreenlessPayment(json) {
    val token: String = getString(TOKEN)

    override fun validate() {
        super.validate()
        if (token.isBlank()) {
            throw ValidationException(ValidationMessages.GOOGLE_PAY_TOKEN_BLANK)
        }
    }

    companion object {
        private const val TOKEN = "token"
    }
}