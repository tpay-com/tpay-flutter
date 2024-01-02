package com.tpay.model

import com.tpay.sdk.api.models.Language
import org.json.JSONObject

class LocalizedString(
    val language: Language,
    val value: String
) {
    companion object {
        private const val LANGUAGE = "language"
        private const val VALUE = "value"

        fun fromJson(json: JSONObject): LocalizedString {
            return LocalizedString(
                language = Language.valueOf(json.getString(LANGUAGE).uppercase()),
                value = json.getString(VALUE)
            )
        }
    }
}