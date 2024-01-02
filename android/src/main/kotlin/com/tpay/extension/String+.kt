package com.tpay.extension

import java.util.regex.Matcher
import java.util.regex.Pattern
import com.tpay.sdk.api.models.Environment
import com.tpay.util.ValidationMessages

fun String.isValidBLIKCode(): Boolean {
    return this.matches(Regex("^[0-9]{6}$"))
}

fun String.isEmailValid(): Boolean {
    return if (isBlank()) {
        false
    } else {
        val matcher: Matcher =
                Pattern
                    .compile("(?:[a-zA-Z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)])")
                    .matcher(this)
        return matcher.matches()
    }
}

fun String.toEnvironment(): Environment {
    return when (this) {
        Environment.PRODUCTION.name.lowercase() -> Environment.PRODUCTION
        Environment.SANDBOX.name.lowercase() -> Environment.SANDBOX
        else -> throw IllegalArgumentException(ValidationMessages.UNKNOWN_ENVIRONMENT)
    }
}