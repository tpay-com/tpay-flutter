package com.tpay.model.screenless

import org.json.JSONObject
import com.tpay.util.ValidationMessages
import com.tpay.extension.*
import com.tpay.util.JsonUtil
import com.tpay.sdk.api.models.payer.Payer
import com.tpay.sdk.api.screenless.Redirects
import com.tpay.sdk.api.screenless.Notifications
import com.tpay.sdk.api.models.Language

open class ScreenlessPayment(json: String) : JSONObject(json) {
    val amount: Double
    val description: String
    val hiddenDescription: String?
    val language: Language?
    val payer: Payer
    val redirects: Redirects?
    val notifications: Notifications?

    init {
        getJSONObject(PAYMENT_DETAILS).let { paymentDetailsJson ->
            amount = paymentDetailsJson.getDouble(AMOUNT)
            description = paymentDetailsJson.getString(DESCRIPTION)
            hiddenDescription = paymentDetailsJson.actuallyOptString(HIDDEN_DESCRIPTION)
            language = paymentDetailsJson.actuallyOptString(LANGUAGE)?.uppercase()?.let { lang ->
                Language.valueOf(lang)
            }
        }
        payer = JsonUtil.getPayer(getJSONObject(PAYER).toString())
        optJSONObject(CALLBACKS).let { callbacksJson ->
            if (callbacksJson == null) {
                redirects = null
                notifications = null
            } else {
                redirects = callbacksJson.optJSONObject(REDIRECTS)?.let { redirectsJson ->
                    Redirects(
                        successUrl = redirectsJson.getString(SUCCESS_URL),
                        errorUrl = redirectsJson.getString(ERROR_URL)
                    )
                }
                notifications = callbacksJson.optJSONObject(NOTIFICATIONS)?.let { notificationsJson ->
                    Notifications(
                        notificationUrl = notificationsJson.getString(URL),
                        notificationEmail = notificationsJson.getString(EMAIL)
                    )
                }
            }
        }
    }

    open fun validate() {
        if (amount <= 0) {
            throw ValidationException(ValidationMessages.AMOUNT_NEGATIVE)
        }
        if (description.isBlank()) {
            throw ValidationException(ValidationMessages.DESCRIPTION_BLANK)
        }
        if (!payer.email.isEmailValid()) {
            throw ValidationException(ValidationMessages.PAYER_EMAIL_INVALID)
        }
        notifications?.let {
            if (!notifications.notificationEmail.isEmailValid()) {
                throw ValidationException(ValidationMessages.NOTIFICATION_EMAIL_INVALID)
            }
        }
    }

    companion object {
        const val PAYMENT_DETAILS = "paymentDetails"
        const val AMOUNT = "amount"
        const val DESCRIPTION = "description"
        const val HIDDEN_DESCRIPTION = "hiddenDescription"
        const val LANGUAGE = "language"
        const val PAYER = "payer"
        const val CALLBACKS = "callbacks"
        const val REDIRECTS = "redirects"
        const val SUCCESS_URL = "successUrl"
        const val ERROR_URL = "errorUrl"
        const val NOTIFICATIONS = "notifications"
        const val URL = "url"
        const val EMAIL = "email"
        const val DELAY_MILLIS = "delayMillis"
        const val MAX_REQUEST_COUNT = "maxRequestCount"
        const val STOP_ON_FIRST_REQUEST_ERROR = "stopOnFirstRequestError"
    }
}