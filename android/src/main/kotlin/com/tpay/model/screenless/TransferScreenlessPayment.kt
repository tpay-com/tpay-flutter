package com.tpay.model.screenless

class TransferScreenlessPayment(json: String) : ScreenlessPayment(json) {
    val groupId: Int = getInt(GROUP_ID)

    companion object {
        private const val GROUP_ID = "groupId"
    }
}