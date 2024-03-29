package com.tpay.model.screenless

class TransferScreenlessPayment(json: String) : ScreenlessPayment(json) {
    val channelId: Int = getInt(CHANNEL_ID)

    companion object {
        private const val CHANNEL_ID = "channelId"
    }
}