package com.tpay.model.screenless

import com.tpay.sdk.api.screenless.card.Recursive
import com.tpay.sdk.api.screenless.card.CreditCard
import com.tpay.sdk.api.models.transaction.*
import java.text.SimpleDateFormat
import com.tpay.util.ValidationMessages
import com.tpay.extension.ValidationException
import com.tpay.extension.actuallyOptString

class CreditCardScreenlessPayment(json: String) : ScreenlessPayment(json) {
    val creditCardData: CreditCardData? = optJSONObject(CREDIT_CARD)?.let { creditCardJson ->
        creditCardJson.getJSONObject(CONFIG).let { configJson ->
            CreditCardData(
                creditCard = CreditCard(
                    cardNumber = creditCardJson.getString(CARD_NUMBER),
                    expirationDate = ExpirationDate.fromJson(
                        creditCardJson.getJSONObject(EXPIRY_DATE)
                    ).toString(),
                    cvv = creditCardJson.getString(CVV)
                ),
                saveCard = configJson.getBoolean(SAVE_CARD),
                domain = configJson.getString(DOMAIN),
                rocText = configJson.actuallyOptString(ROC_TEXT)
            )
        }
    }

    val recursive: Recursive? = optJSONObject(RECURSIVE)?.run {
        Recursive(
            frequency = Frequency.values()[getInt(FREQUENCY) - 1],
            quantity = optInt(QUANTITY, -1).let { value ->
                when (value) {
                    -1 -> Quantity.Indefinite
                    else -> Quantity.Specified(value)
                }
            },
            expirationDate = SimpleDateFormat(DATE_FORMAT).parse(getString(END_DATE))
        )
    }

    val cardToken: String? = actuallyOptString(CARD_TOKEN)

    override fun validate() {
        super.validate()

        if (cardToken == null && creditCardData == null) {
            throw ValidationException(ValidationMessages.CREDIT_CARD_DATA_NULL)
        }
    }

    companion object {
        private const val CREDIT_CARD = "creditCard"
        private const val RECURSIVE = "recursive"
        private const val CARD_NUMBER = "cardNumber"
        private const val EXPIRY_DATE = "expiryDate"
        private const val END_DATE = "endDate"
        private const val CVV = "cvv"
        private const val FREQUENCY = "frequency"
        private const val QUANTITY = "quantity"
        private const val CARD_TOKEN = "creditCardToken"
        private const val SAVE_CARD = "shouldSave"
        private const val DOMAIN = "domain"
        private const val ROC_TEXT = "rocText"
        private const val CONFIG = "config"

        private const val DATE_FORMAT = "yyyy-MM-dd"
    }
}