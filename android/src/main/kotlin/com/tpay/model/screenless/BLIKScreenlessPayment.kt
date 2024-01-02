package com.tpay.model.screenless

import com.tpay.sdk.api.models.BlikAlias
import org.json.JSONObject
import com.tpay.util.ValidationMessages
import com.tpay.extension.*

class BLIKScreenlessPayment(json: String) : ScreenlessPayment(json) {
    val code: String? = actuallyOptString(CODE)
    val alias: BlikAlias? = optJSONObject(ALIAS)?.run { getBlikAlias() }

    override fun validate() {
        super.validate()
        if (code.isNullOrBlank() && alias == null) {
            throw ValidationException(ValidationMessages.BLIK_CODE_AND_ALIAS_NULL)
        }
        code?.let {
            if (!code.isValidBLIKCode()) {
                throw ValidationException(ValidationMessages.BLIK_CODE_INVALID)
            }
        }
    }

    companion object {
        private const val CODE = "code"
        private const val ALIAS = "alias"
    }
}