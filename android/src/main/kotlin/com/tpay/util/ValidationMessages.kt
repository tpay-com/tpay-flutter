package com.tpay.util

object ValidationMessages {
    const val AMOUNT_NEGATIVE = "Amount has to be greater than 0"
    const val DESCRIPTION_BLANK = "Description cannot be blank"
    const val CARD_TOKEN_BLANK = "Card token cannot be blank"
    const val BLIK_CODE_AND_ALIAS_NULL = "Please provide BLIK code or alias"
    const val BLIK_CODE_INVALID = "BLIK code is invalid"
    const val LONG_POLLING_DELAY_NEGATIVE = "Long polling delay has to be greater than 0"
    const val LONG_POLLING_MAX_REQUEST_COUNT_NEGATIVE = "Long polling max request count has to be greater than 0"
    const val NOTIFICATION_EMAIL_INVALID = "Notification email is invalid"
    const val PAYER_EMAIL_INVALID = "Payer email is invalid"
    const val CREDIT_CARD_DATA_NULL = "Please provide credit card data or credit card token"
    const val PROVIDE_LOCALIZATION_MESSAGE = "Provide display names and regulations for all defined languages"
    const val PUBLIC_KEY_INVALID_MESSAGE = "Public key should start with ${Constants.BEGIN_PUBLIC_KEY} and end with ${Constants.END_PUBLIC_KEY}"
    const val UNKNOWN_ENVIRONMENT = "Unknown Tpay environment"
    const val CREDENTIALS_BLANK = "Credentials cannot be blank"
    const val GOOGLE_PAY_TOKEN_BLANK = "Google Pay token cannot be blank"
    const val PAYER_REQUIRED_TOKEN_PAYMENT = "Payer's name and email are required for credit card token payment"
}