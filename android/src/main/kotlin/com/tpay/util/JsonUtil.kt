package com.tpay.util

import com.tpay.sdk.api.models.transaction.SingleTransaction
import org.json.JSONObject
import com.tpay.sdk.api.models.payer.Payer
import com.tpay.sdk.api.models.*
import com.tpay.sdk.api.paycard.CreditCardBrand
import com.tpay.sdk.api.models.PayerContext
import com.tpay.sdk.api.cardTokenPayment.CardTokenTransaction
import com.tpay.sdk.api.screenless.Notifications
import com.tpay.sdk.api.addCard.Tokenization
import com.tpay.extension.*
import com.tpay.util.ValidationMessages
import com.tpay.extension.ValidationException

object JsonUtil {
    private const val NAME = "name"
    private const val EMAIL = "email"
    private const val PHONE = "phone"
    private const val ADDRESS = "address"
    private const val CITY = "city"
    private const val COUNTRY_CODE = "countryCode"
    private const val POSTAL_CODE = "postalCode"
    private const val AMOUNT = "amount"
    private const val DESCRIPTION = "description"
    private const val PAYER = "payer"
    private const val CARD_TOKEN = "cardToken"
    private const val PAYER_CONTEXT = "payerContext"
    private const val NOTIFICATIONS = "notifications"
    private const val AUTOMATIC_PAYMENT_METHODS = "automaticPaymentMethods"
    private const val TOKENIZED_CARDS = "tokenizedCards"
    private const val BLIK_ALIAS = "blikAlias"
    private const val TOKEN = "token"
    private const val CARD_TAIL = "cardTail"
    private const val BRAND = "brand"
    private const val MASTERCARD = "mastercard"
    private const val VISA = "visa"
    private const val VALUE = "value"
    private const val LABEL = "label"
    private const val URL = "url"
    private const val NOTIFICATION_URL = "notificationUrl"
    private const val IS_REGISTERED = "isRegistered"

    fun getTokenization(json: String): Tokenization {
        val rootJson = JSONObject(json)

        return Tokenization(
            payer = getPayer(rootJson.optJSONObject(PAYER)?.toString()),
            notificationUrl = rootJson.getString(NOTIFICATION_URL)
        )
    }

    fun getPayer(json: String?): Payer {
        json ?: return Payer(
            name = "",
            email = "",
            phone = null,
            address = null
        )

        val rootJson = JSONObject(json)

        val name = rootJson.actuallyOptString(NAME)
        val email = rootJson.actuallyOptString(EMAIL)
        val phone = rootJson.actuallyOptString(PHONE)

        val addressJson = rootJson.optJSONObject(ADDRESS)
        val address = addressJson?.actuallyOptString(ADDRESS)
        val city = addressJson?.actuallyOptString(CITY)
        val countryCode = addressJson?.actuallyOptString(COUNTRY_CODE)
        val postalCode = addressJson?.actuallyOptString(POSTAL_CODE)

        return Payer(
            name = name ?: "",
            email = email ?: "",
            phone = phone,
            address = address?.run {
                Payer.Address(
                    address = address,
                    city = city,
                    countryCode = countryCode,
                    postalCode = postalCode
                )
            }
        )
    }

    fun getCardTokenTransaction(json: String): CardTokenTransaction {
        val rootJson = JSONObject(json)

        val amount = rootJson.getDouble(AMOUNT)
        val description = rootJson.getString(DESCRIPTION)
        val payerJson = rootJson.optJSONObject(PAYER)
        payerJson ?: throw ValidationException(ValidationMessages.PAYER_REQUIRED_TOKEN_PAYMENT)
        val payer = getPayer(payerJson.toString())
        val cardToken = rootJson.getString(CARD_TOKEN)

        val notifications = rootJson.optJSONObject(NOTIFICATIONS)?.let { json ->
            Notifications(
                notificationUrl = json.getString(URL),
                notificationEmail = json.getString(EMAIL)
            )
        }

        return CardTokenTransaction(
            amount = amount,
            description = description,
            payer = payer,
            cardToken = cardToken,
            notifications = notifications
        )
    }

    fun getSingleTransaction(json: String): SingleTransaction {
        val rootJson = JSONObject(json)

        val amount = rootJson.getDouble(AMOUNT)
        val description = rootJson.getString(DESCRIPTION)

        val notifications = rootJson.optJSONObject(NOTIFICATIONS)?.let { json ->
            Notifications(
                notificationUrl = json.getString(URL),
                notificationEmail = json.getString(EMAIL)
            )
        }

        val payerContextJson = rootJson.getJSONObject(PAYER_CONTEXT)

        val payerJson = payerContextJson.optJSONObject(PAYER)
        val payer = getPayer(payerJson?.toString())

        val automaticPaymentMethodsJson = payerContextJson.optJSONObject(AUTOMATIC_PAYMENT_METHODS)

        val (tokenizedCards, blikAlias) = automaticPaymentMethodsJson?.let { automaticPaymentsJson ->
            val tokenizedCardsArray = automaticPaymentMethodsJson.optJSONArray(TOKENIZED_CARDS)
            val blikAliasJson = automaticPaymentMethodsJson.optJSONObject(BLIK_ALIAS)

            val tokenizedCards: List<TokenizedCard> = tokenizedCardsArray?.run {
                (0 until length())
                    .map { index -> getJSONObject(index) }
                    .map { tokenizedCardObject ->
                        TokenizedCard(
                            token = tokenizedCardObject.getString(TOKEN),
                            cardTail = tokenizedCardObject.getString(CARD_TAIL),
                            brand = when (tokenizedCardObject.getString(BRAND)) {
                                MASTERCARD -> CreditCardBrand.MASTERCARD
                                VISA -> CreditCardBrand.VISA
                                else -> CreditCardBrand.UNKNOWN
                            }
                        )
                    }
            } ?: emptyList<TokenizedCard>()

            val blikAlias: BlikAlias? = blikAliasJson?.run {
                val label = getString(LABEL)
                val value = getString(VALUE)
                if (getBoolean(IS_REGISTERED)) {
                    BlikAlias.Registered(value, label)
                } else {
                    BlikAlias.NotRegistered(value, label)
                }
            } ?: null

            tokenizedCards to blikAlias
        } ?: emptyList<TokenizedCard>() to null

        val payerContext = PayerContext(
            payer = payer,
            automaticPaymentMethods = AutomaticPaymentMethods(
                blikAlias = blikAlias,
                tokenizedCards = tokenizedCards
            )
        )

        return SingleTransaction(
            amount = amount,
            description = description,
            payerContext = payerContext,
            notifications = notifications
        )
    }
}