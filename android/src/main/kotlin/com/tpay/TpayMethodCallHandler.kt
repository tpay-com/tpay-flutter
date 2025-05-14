package com.tpay

import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import com.tpay.model.TpayConfiguration
import com.tpay.model.TpayScreenlessConfiguration
import com.tpay.util.JsonUtil
import org.json.JSONObject
import org.json.JSONArray
import com.tpay.extension.*
import android.content.Intent
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.embedding.android.FlutterFragmentActivity
import com.tpay.sdk.api.payment.*
import com.tpay.sdk.api.cardTokenPayment.*
import com.tpay.util.TpayUtil
import com.tpay.util.TpayBackpressUtil
import com.tpay.sdk.api.addCard.*
import com.tpay.delegate.*
import com.tpay.model.screenless.*
import com.tpay.model.Configuration
import com.tpay.sdk.api.models.*
import com.tpay.sdk.api.screenless.googlePay.*
import com.tpay.model.googlePay.*
import com.tpay.sdk.api.screenless.blik.*
import com.tpay.sdk.api.screenless.channelMethods.*

class TpayMethodCallHandler(
    private val binaryMessenger: BinaryMessenger
) : PluginRegistry.ActivityResultListener {
    var activity: FlutterFragmentActivity? = null
    private var channel: MethodChannel? = null
    private var sheet: Presentable? = null
    var googlePayUtil: GooglePayUtil? = null
    var googlePayOpenResult: Result? = null
    private var eventSink: EventSink? = null

    init {
        EventChannel(binaryMessenger, EVENT_CHANNEL_NAME).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
        MethodChannel(binaryMessenger, METHOD_CHANNEL_NAME).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    CONFIGURE_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleConfiguration<TpayConfiguration>(json, result)
                        } ?: handleResult(TpayResult.MethodCallError(CONFIGURATION_NULL_MESSAGE), result)
                    }

                    CONFIGURE_SCREENLESS_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleConfiguration<TpayScreenlessConfiguration>(json, result)
                        } ?: handleResult(TpayResult.MethodCallError(CONFIGURATION_NULL_MESSAGE), result)
                    }

                    START_PAYMENT_METHOD -> {
                        val safeActivity = activity ?: kotlin.run {
                            handleResult(
                                TpayResult.MethodCallError(ACTIVITY_NULL_MESSAGE),
                                result
                            )
                            return@setMethodCallHandler
                        }
                        call.stringArgument?.let { json ->
                            try {
                                val singleTransaction = JsonUtil.getSingleTransaction(json)
                                singleTransaction.validate()
                                Payment.Sheet(
                                    transaction = singleTransaction,
                                    activity = safeActivity,
                                    supportFragmentManager = safeActivity.supportFragmentManager
                                ).apply {
                                    addObserver(PaymentDelegateImpl(this, { tpayResult ->
                                        handleResult(tpayResult, result)
                                    }, { tpayIntermediateResult ->
                                        handleIntermediateResult(tpayIntermediateResult)
                                    }))
                                    handleSheetOpenResult(
                                        this,
                                        present(),
                                        result
                                    )
                                }
                            } catch (exception: Exception) {
                                handleException(exception, result)
                            }
                        } ?: handleResult(TpayResult.MethodCallError(TRANSACTION_NULL_MESSAGE), result)
                    }

                    TOKENIZE_CARD -> {
                        val safeActivity = activity ?: kotlin.run {
                            handleResult(
                                TpayResult.MethodCallError(ACTIVITY_NULL_MESSAGE), result
                            )
                            return@setMethodCallHandler
                        }
                        call.stringArgument?.let { json ->
                            try {
                                val tokenization = JsonUtil.getTokenization(json)
                                AddCard.Sheet(
                                    tokenization = tokenization,
                                    activity = safeActivity,
                                    supportFragmentManager = safeActivity.supportFragmentManager
                                ).apply {
                                    addObserver(AddCardDelegateImpl(this) { tpayResult ->
                                        handleResult(tpayResult, result)
                                    })
                                    handleSheetOpenResult(
                                        this,
                                        present(),
                                        result
                                    )
                                }
                            } catch (exception: Exception) {
                                handleException(exception, result)
                            }
                        } ?: handleResult(TpayResult.MethodCallError(PAYER_NULL_MESSAGE), result)
                    }

                    START_CARD_TOKEN_TRANSACTION_METHOD -> {
                        val safeActivity = activity ?: kotlin.run {
                            handleResult(
                                TpayResult.MethodCallError(ACTIVITY_NULL_MESSAGE),
                                result
                            )
                            return@setMethodCallHandler
                        }
                        call.stringArgument?.let { json ->
                            try {
                                val cardTokenTransaction = JsonUtil.getCardTokenTransaction(json)
                                cardTokenTransaction.validate()
                                CardTokenPayment.Sheet(
                                    transaction = cardTokenTransaction,
                                    activity = safeActivity,
                                    supportFragmentManager = safeActivity.supportFragmentManager
                                ).apply {
                                    addObserver(PaymentDelegateImpl(this, { tpayResult ->
                                        handleResult(tpayResult, result)
                                    }, { tpayIntermediateResult ->
                                        handleIntermediateResult(tpayIntermediateResult)
                                    }))
                                    handleSheetOpenResult(
                                        this,
                                        present(),
                                        result
                                    )
                                }
                            } catch (exception: Exception) {
                                handleException(exception, result)
                            }
                        } ?: handleResult(TpayResult.MethodCallError(TOKEN_PAYMENT_NULL_MESSAGE), result)
                    }

                    GET_PAYMENT_CHANNELS_METHOD -> {
                        GetPaymentChannels().execute { channelsResult ->
                            handlePaymentChannelsResult(channelsResult, result)
                        }
                    }

                    SCREENLESS_BLIK_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleScreenlessPayment<BLIKScreenlessPayment>(json, result)
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_BLIK_NULL_MESSAGE),
                            result
                        )
                    }

                    SCREENLESS_AMBIGUOUS_BLIK_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            try {
                                val payment = AmbiguousBLIKPayment.fromJson(json)
                                TpayAmbiguousBLIKPaymentHandler(payment) { screenlessResult ->
                                    handleScreenlessResult(screenlessResult, result)
                                }
                            } catch (exception: Exception) {
                                handleScreenlessException(exception, result)
                            }
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_BLIK_NULL_MESSAGE),
                            result
                        )
                    }

                    SCREENLESS_TRANSFER_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleScreenlessPayment<TransferScreenlessPayment>(json, result)
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_TRANSFER_NULL_MESSAGE),
                            result
                        )
                    }

                    SCREENLESS_RATY_PEKAO_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleScreenlessPayment<RatyPekaoScreenlessPayment>(json, result)
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_RATY_PEKAO_NULL_MESSAGE),
                            result
                        )
                    }

                    SCREENLESS_PAY_PO_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleScreenlessPayment<PayPoScreenlessPayment>(json, result)
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_PAY_PO_NULL_MESSAGE),
                            result
                        )
                    }

                    SCREENLESS_CREDIT_CARD_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleScreenlessPayment<CreditCardScreenlessPayment>(json, result)
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_TRANSFER_NULL_MESSAGE),
                            result
                        )
                    }

                    SCREENLESS_GOOGLE_PAY_PAYMENT_METHOD -> {
                        call.stringArgument?.let { json ->
                            handleScreenlessPayment<GooglePayScreenlessPayment>(json, result)
                        } ?: handleScreenlessResult(
                            TpayScreenlessResult.MethodCallError(SCREENLESS_TRANSFER_NULL_MESSAGE),
                            result
                        )
                    }

                    CONFIGURE_GOOGLE_PAY_UTILS_METHOD -> {
                        val safeActivity = activity ?: kotlin.run {
                            handleGooglePayConfigurationResult(
                                GooglePayConfigureResult.Error(ACTIVITY_NULL_MESSAGE),
                                result
                            )
                            return@setMethodCallHandler
                        }
                        call.stringArgument?.let { json ->
                            try {
                                val googlePayConfiguration = GooglePayUtilsConfiguration.fromJson(json)
                                googlePayConfiguration.validate()
                                googlePayUtil = GooglePayUtil(
                                    activity = safeActivity,
                                    googlePayRequest = GooglePayRequest(
                                        price = googlePayConfiguration.price,
                                        merchantName = googlePayConfiguration.merchantName,
                                        merchantId = googlePayConfiguration.merchantId
                                    ),
                                    googlePayEnvironment = googlePayConfiguration.environment,
                                    customRequestCode = googlePayConfiguration.customRequestCode
                                )
                                handleGooglePayConfigurationResult(GooglePayConfigureResult.Success, result)
                            } catch (exception: Exception) {
                                handleGooglePayConfigurationResult(
                                    GooglePayConfigureResult.Error(
                                        if (exception is ValidationException) exception.message
                                        else GOOGLE_PAY_CONFIGURATION_INVALID
                                    ),
                                    result
                                )
                            }
                        } ?: handleGooglePayConfigurationResult(
                            GooglePayConfigureResult.Error(GOOGLE_PAY_CONFIGURATION_NULL_MESSAGE),
                            result
                        )
                    }

                    OPEN_GOOGLE_PAY_METHOD -> {
                        googlePayUtil?.run {
                            googlePayOpenResult = result
                            openGooglePay()
                        } ?: handleGooglePayOpenResult(null, result)

                    }

                    IS_GOOGLE_PAY_AVAILABLE_METHOD -> {
                        googlePayUtil?.run {
                            checkIfGooglePayIsAvailable(result::success)
                        } ?: result.success(false)
                    }
                }
            }
        }.also { methodChannel -> channel = methodChannel }
    }

    fun dispose() {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?): Boolean {
        (sheet as? Payment.Sheet)?.onActivityResult(requestCode, resultCode, intent)
        googlePayUtil?.handleActivityResult(requestCode, resultCode, intent) { result ->
            googlePayOpenResult?.run {
                handleGooglePayOpenResult(result, this)
                googlePayOpenResult = null
            }
        }

        return true
    }

    private fun handleResult(tpayResult: TpayResult, result: Result) {
        sheet = null

        val (type, value) = when (tpayResult) {
            is TpayResult.ConfigurationSuccess -> CONFIGURATION_SUCCESS to null
            is TpayResult.ValidationError -> VALIDATION_ERROR to tpayResult.message
            is TpayResult.PaymentCompleted -> PAYMENT_COMPLETED to tpayResult.transactionId
            is TpayResult.PaymentCancelled -> PAYMENT_CANCELLED to tpayResult.transactionId
            is TpayResult.TokenizationCompleted -> TOKENIZATION_COMPLETED to null
            is TpayResult.TokenizationFailure -> TOKENIZATION_FAILURE to null
            is TpayResult.MethodCallError -> METHOD_CALL_ERROR to tpayResult.message
            is TpayResult.ModuleClosed -> MODULE_CLOSED to null
            else -> UNKNOWN to null
        }

        JSONObject().apply {
            put(TYPE, type)
            put(VALUE, value)
        }.toString().let(result::success)
    }

    private fun handleIntermediateResult(tpayIntermediateResult: TpayResult) {
        val (type, value) = when (tpayIntermediateResult) {
            is TpayResult.PaymentCreated -> PAYMENT_CREATED to tpayIntermediateResult.transactionId
            else -> UNKNOWN to null
        }

        JSONObject().apply {
            put(TYPE, type)
            put(VALUE, value)
        }.toString().let { jsonString ->
            eventSink?.success(jsonString)
        }
    }

    private fun handlePaymentChannelsResult(channelsResult: GetPaymentChannelsResult, result: Result) {
        JSONObject().apply {
            when (channelsResult) {
                is GetPaymentChannelsResult.Success -> {
                    put(TYPE, SUCCESS)
                    put(CHANNELS, channelsResult.channels.filter { channel -> channel.isAvailable }.toJsonArray())
                }

                is GetPaymentChannelsResult.Error -> {
                    put(TYPE, ERROR)
                    put(MESSAGE, channelsResult.devErrorMessage)
                }
            }
        }.toString().let(result::success)
    }

    private fun handleGooglePayConfigurationResult(
        googlePayConfigureResult: GooglePayConfigureResult, result: Result
    ) {
        val (type, errorMessage) = when (googlePayConfigureResult) {
            is GooglePayConfigureResult.Success -> GOOGLE_PAY_CONFIGURATION_SUCCESS to null
            is GooglePayConfigureResult.Error -> GOOGLE_PAY_CONFIGURATION_ERROR to googlePayConfigureResult.errorMessage
        }

        JSONObject().apply {
            put(TYPE, type)
            put(MESSAGE, errorMessage)
        }.toString().let(result::success)
    }

    private fun handleGooglePayOpenResult(
        openGooglePayResult: OpenGooglePayResult?,
        result: Result
    ) {
        JSONObject().apply {
            when (openGooglePayResult) {
                is OpenGooglePayResult.Success -> {
                    put(TYPE, GOOGLE_PAY_OPEN_SUCCESS)
                    put(GOOGLE_PAY_TOKEN, openGooglePayResult.token)
                    put(GOOGLE_PAY_DESCRIPTION, openGooglePayResult.description)
                    put(GOOGLE_PAY_CARD_NETWORK, openGooglePayResult.cardNetwork)
                    put(GOOGLE_PAY_CARD_TAIL, openGooglePayResult.cardTail)
                }

                is OpenGooglePayResult.Cancelled -> {
                    put(TYPE, GOOGLE_PAY_OPEN_CANCELLED)
                }

                is OpenGooglePayResult.UnknownError -> {
                    put(TYPE, GOOGLE_PAY_OPEN_UNKNOWN_ERROR)
                }

                else -> {
                    put(TYPE, GOOGLE_PAY_OPEN_NOT_CONFIGURED)
                }
            }
        }.toString().let(result::success)
    }

    private fun handleSheetOpenResult(
        presentable: Presentable,
        sheetOpenResult: SheetOpenResult,
        result: Result
    ) {
        when (sheetOpenResult) {
            is SheetOpenResult.Success -> {
                sheet = presentable
                TpayBackpressUtil.set(presentable)
            }

            is SheetOpenResult.ConfigurationInvalid -> {
                handleResult(
                    TpayResult.ValidationError(
                        CONFIGURATION_INVALID_MESSAGE + sheetOpenResult.devMessage
                    ), result
                )
            }

            is SheetOpenResult.UnexpectedError -> {
                handleResult(
                    TpayResult.MethodCallError(sheetOpenResult.devErrorMessage ?: UNKNOWN_ERROR),
                    result
                )
            }
        }
    }

    private inline fun <reified T : Configuration> handleConfiguration(json: String, result: Result) {
        try {
            val configuration = when (T::class) {
                TpayConfiguration::class -> TpayConfiguration.fromJson(json)
                else -> throw IllegalArgumentException(NOT_IMPLEMENTED_CONFIGURATION_TYPE_MESSAGE)
            }
            configuration.validate()
            TpayUtil.configure(configuration)
            handleResult(TpayResult.ConfigurationSuccess, result)
        } catch (exception: Exception) {
            handleException(exception, result)
        }
    }

    private inline fun <reified T : ScreenlessPayment> handleScreenlessPayment(json: String, result: Result) {
        try {
            val payment = when (T::class) {
                BLIKScreenlessPayment::class -> BLIKScreenlessPayment(json)
                TransferScreenlessPayment::class -> TransferScreenlessPayment(json)
                RatyPekaoScreenlessPayment::class -> RatyPekaoScreenlessPayment(json)
                PayPoScreenlessPayment::class -> PayPoScreenlessPayment(json)
                CreditCardScreenlessPayment::class -> CreditCardScreenlessPayment(json)
                GooglePayScreenlessPayment::class -> GooglePayScreenlessPayment(json)
                else -> throw IllegalArgumentException(NOT_IMPLEMENTED_SCREENLESS_PAYMENT_MESSAGE)
            }
            payment.validate()
            TpayScreenlessPaymentHandler(payment) { screenlessResult ->
                handleScreenlessResult(screenlessResult, result)
            }
        } catch (exception: Exception) {
            handleScreenlessException(exception, result)
        }
    }

    private fun handleScreenlessResult(
        screenlessResult: TpayScreenlessResult,
        result: Result
    ) {
        val data = when (screenlessResult) {
            is TpayScreenlessResult.Paid -> {
                ScreenlessResultData(
                    type = PAID,
                    transactionId = screenlessResult.transactionId
                )
            }

            is TpayScreenlessResult.PaymentCreated -> {
                ScreenlessResultData(
                    type = PAYMENT_CREATED,
                    transactionId = screenlessResult.transactionId,
                    paymentUrl = screenlessResult.paymentUrl
                )
            }

            is TpayScreenlessResult.ConfiguredPaymentFailed -> {
                ScreenlessResultData(
                    type = CONFIGURED_PAYMENT_FAILED,
                    transactionId = screenlessResult.transactionId,
                    message = screenlessResult.errorMessage
                )
            }

            is TpayScreenlessResult.BlikAmbiguousAlias -> {
                ScreenlessResultData(
                    type = AMBIGUOUS_ALIAS,
                    transactionId = screenlessResult.transactionId,
                    ambiguousAliases = screenlessResult.ambiguousAliases
                )
            }

            is TpayScreenlessResult.Error -> {
                ScreenlessResultData(
                    type = ERROR,
                    message = screenlessResult.errorMessage
                )
            }

            is TpayScreenlessResult.ValidationError -> {
                ScreenlessResultData(
                    type = VALIDATION_ERROR,
                    message = screenlessResult.message
                )
            }

            is TpayScreenlessResult.MethodCallError -> {
                ScreenlessResultData(
                    type = METHOD_CALL_ERROR,
                    message = screenlessResult.message
                )
            }
        }

        JSONObject().apply {
            put(TYPE, data.type)
            put(TRANSACTION_ID, data.transactionId)
            put(MESSAGE, data.message)
            put(PAYMENT_URL, data.paymentUrl)
            data.ambiguousAliases?.let { aliases ->
                put(
                    ALIASES,
                    JSONArray().apply {
                        aliases.map { alias -> JSONObject(alias.toJson()) }.forEach(this::put)
                    }
                )
            }
        }.toString().let(result::success)
    }

    private fun handleException(exception: Exception, result: Result) {
        handleResult(
            if (exception is ValidationException) {
                TpayResult.ValidationError(exception.message ?: UNKNOWN_VALIDATION_ERROR_MESSAGE)
            } else {
                TpayResult.MethodCallError(exception.message ?: UNKNOWN_ERROR)
            }, result
        )
    }

    private fun handleScreenlessException(exception: Exception, result: Result) {
        handleScreenlessResult(
            if (exception is ValidationException) {
                TpayScreenlessResult.ValidationError(exception.message ?: UNKNOWN_VALIDATION_ERROR_MESSAGE)
            } else {
                TpayScreenlessResult.MethodCallError(exception.message ?: UNKNOWN_ERROR)
            }, result
        )
    }

    private data class ScreenlessResultData(
        val type: String,
        val transactionId: String? = null,
        val message: String? = null,
        val paymentUrl: String? = null,
        val ambiguousAliases: List<AmbiguousAlias> = emptyList()
    )

    companion object {
        private const val METHOD_CHANNEL_NAME = "tpay"
        private const val EVENT_CHANNEL_NAME = "tpay.event"
        private const val CONFIGURE_METHOD = "configure"
        private const val CONFIGURE_SCREENLESS_METHOD = "configureScreenless"
        private const val START_PAYMENT_METHOD = "startPayment"
        private const val TOKENIZE_CARD = "tokenizeCard"
        private const val SCREENLESS_BLIK_PAYMENT_METHOD = "screenlessBLIKPayment"
        private const val SCREENLESS_AMBIGUOUS_BLIK_PAYMENT_METHOD = "screenlessAmbiguousBLIKPayment"
        private const val SCREENLESS_TRANSFER_PAYMENT_METHOD = "screenlessTransferPayment"
        private const val SCREENLESS_RATY_PEKAO_PAYMENT_METHOD = "screenlessRatyPekaoPayment"
        private const val SCREENLESS_PAY_PO_PAYMENT_METHOD = "screenlessPayPoPayment"
        private const val SCREENLESS_CREDIT_CARD_PAYMENT_METHOD = "screenlessCreditCardPayment"
        private const val SCREENLESS_GOOGLE_PAY_PAYMENT_METHOD = "screenlessGooglePayPayment"
        private const val GET_PAYMENT_CHANNELS_METHOD = "getPaymentChannels"
        private const val CONFIGURE_GOOGLE_PAY_UTILS_METHOD = "configureGooglePayUtils"
        private const val OPEN_GOOGLE_PAY_METHOD = "openGooglePay"
        private const val IS_GOOGLE_PAY_AVAILABLE_METHOD = "isGooglePayAvailable"

        private const val START_CARD_TOKEN_TRANSACTION_METHOD = "startCardTokenPayment"
        private const val CONFIGURATION_NULL_MESSAGE = "Configuration cannot be null"
        private const val CONFIGURATION_INVALID_MESSAGE = "Configuration invalid: "
        private const val TRANSACTION_NULL_MESSAGE = "Transaction cannot be null"
        private const val UNKNOWN_CONFIGURATION_ERROR_MESSAGE = "Unknown configuration error"
        private const val PAYER_NULL_MESSAGE = "Payer cannot be null"
        private const val TOKEN_PAYMENT_NULL_MESSAGE = "CardTokenPayment cannot be null"
        private const val UNKNOWN_VALIDATION_ERROR_MESSAGE = "Unknown validation error"
        private const val ACTIVITY_NULL_MESSAGE = "Activity cannot be null"
        private const val UNKNOWN_ERROR = "Unknown error"
        private const val SCREENLESS_BLIK_NULL_MESSAGE = "Screenless BLIK cannot be null"
        private const val SCREENLESS_TRANSFER_NULL_MESSAGE = "Screenless transfer cannot be null"
        private const val SCREENLESS_RATY_PEKAO_NULL_MESSAGE = "Screenless Raty Pekao cannot be null"
        private const val SCREENLESS_PAY_PO_NULL_MESSAGE = "Screenless PayPo cannot be null"
        const val NOT_IMPLEMENTED_SCREENLESS_PAYMENT_MESSAGE = "Not implemented screenless payment type"
        const val NOT_IMPLEMENTED_CONFIGURATION_TYPE_MESSAGE = "Not implemented configuration type"
        private const val GOOGLE_PAY_CONFIGURATION_NULL_MESSAGE = "Google Pay configuration cannot be null"
        private const val GOOGLE_PAY_CONFIGURATION_INVALID = "Google Pay configuration is invalid"

        private const val CONFIGURATION_SUCCESS = "configurationSuccess"
        private const val VALIDATION_ERROR = "validationError"
        private const val PAYMENT_COMPLETED = "paymentCompleted"
        private const val PAYMENT_CANCELLED = "paymentCancelled"
        private const val TOKENIZATION_COMPLETED = "tokenizationCompleted"
        private const val TOKENIZATION_FAILURE = "tokenizationFailure"
        private const val METHOD_CALL_ERROR = "methodCallError"
        private const val MODULE_CLOSED = "moduleClosed"
        private const val UNKNOWN = "unknown"

        private const val PAYMENT_METHODS = "paymentMethods"
        private const val SUCCESS = "success"
        private const val PAID = "paid"
        private const val PAYMENT_CREATED = "paymentCreated"
        private const val CONFIGURED_PAYMENT_FAILED = "configuredPaymentFailed"
        private const val ERROR = "error"
        private const val DEV_ERROR_MESSAGE = "devErrorMessage"
        private const val AMBIGUOUS_ALIAS = "ambiguousAlias"
        private const val ALIASES = "aliases"

        private const val CHANNELS = "channels"

        private const val TYPE = "type"
        private const val VALUE = "value"
        private const val TRANSACTION_ID = "transactionId"
        private const val MESSAGE = "message"
        private const val PAYMENT_URL = "paymentUrl"

        private const val GOOGLE_PAY_CONFIGURATION_SUCCESS = "success"
        private const val GOOGLE_PAY_CONFIGURATION_ERROR = "error"

        private const val GOOGLE_PAY_OPEN_SUCCESS = "success"
        private const val GOOGLE_PAY_OPEN_CANCELLED = "cancelled"
        private const val GOOGLE_PAY_OPEN_UNKNOWN_ERROR = "unknownError"
        private const val GOOGLE_PAY_OPEN_NOT_CONFIGURED = "notConfigured"

        private const val GOOGLE_PAY_TOKEN = "token"
        private const val GOOGLE_PAY_DESCRIPTION = "description"
        private const val GOOGLE_PAY_CARD_NETWORK = "cardNetwork"
        private const val GOOGLE_PAY_CARD_TAIL = "cardTail"
    }
}