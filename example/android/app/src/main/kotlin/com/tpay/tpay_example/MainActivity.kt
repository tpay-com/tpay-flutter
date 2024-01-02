package com.tpay.tpay_example

import io.flutter.embedding.android.FlutterFragmentActivity
import com.tpay.util.TpayBackpressUtil

class MainActivity: FlutterFragmentActivity() {
    override fun onBackPressed() {
        if (TpayBackpressUtil.isModuleVisible) {
            TpayBackpressUtil.onBackPressed()
        } else {
            super.onBackPressed()
        }
    }
}