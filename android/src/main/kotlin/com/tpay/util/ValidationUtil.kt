package com.tpay.util

import com.tpay.extension.ValidationException

object ValidationUtil {
    fun validatePublicKey(publicKey: String) {
        if (!publicKey.startsWith(Constants.BEGIN_PUBLIC_KEY) || !publicKey.endsWith(Constants.END_PUBLIC_KEY)) {
            throw ValidationException(ValidationMessages.PUBLIC_KEY_INVALID_MESSAGE)
        }
    }
}