package com.tpay.model.screenless

import org.json.JSONObject
import com.tpay.sdk.api.screenless.blik.AmbiguousAlias

data class AmbiguousBLIKAlias(
    val name: String,
    val code: String
) {
    fun toJson(): String {
        return JSONObject().apply {
            put(NAME, name)
            put(CODE, code)
        }.toString()
    }

    fun toAmbiguousAlias(): AmbiguousAlias {
        return AmbiguousAlias(
            name = name,
            code = code
        )
    }

    companion object {
        private const val NAME = "name"
        private const val CODE = "code"

        fun fromJson(jsonObject: JSONObject): AmbiguousBLIKAlias = jsonObject.run {
            AmbiguousBLIKAlias(
                name = getString(NAME),
                code = getString(CODE)
            )
        }
    }
}