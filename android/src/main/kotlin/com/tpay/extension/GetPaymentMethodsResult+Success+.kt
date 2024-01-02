package com.tpay.extension

import com.tpay.sdk.api.screenless.paymentMethods.GetPaymentMethodsResult
import org.json.*
import com.tpay.sdk.api.models.DigitalWallet

fun GetPaymentMethodsResult.Success.toJson(): JSONObject {
    return JSONObject().apply {
        put("isCreditCardPaymentAvailable", isCreditCardPaymentAvailable)
        put("isBLIKPaymentAvailable", isBLIKPaymentAvailable)
        put(
            "availableTransferMethods",
            JSONArray().apply {
                availableTransferMethods.forEach { transferMethod ->
                    put(
                        JSONObject().apply {
                            put("id", transferMethod.id)
                            put("name", transferMethod.name)
                            put("imageUrl", transferMethod.imageUrl)
                        }
                    )
                }
            }
        )
        put(
            "availableDigitalWallets",
            JSONArray().apply {
                if (availableDigitalWallets.contains(DigitalWallet.GOOGLE_PAY)) put("googlePay")
            }
        )
    }
}