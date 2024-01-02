package com.tpay.model

import com.tpay.sdk.api.models.Language
import org.json.JSONObject

data class Languages(
    val preferredLanguage: Language,
    val supportedLanguages: List<Language>
) {
    companion object {
        private const val PREFERRED_LANGUAGE = "preferredLanguage"
        private const val SUPPORTED_LANGUAGES_ARRAY = "supportedLanguages"

        fun fromJson(json: JSONObject): Languages {
            val supportedLanguagesArray = json.getJSONArray(SUPPORTED_LANGUAGES_ARRAY)
            return Languages(
                preferredLanguage = Language.valueOf(json.getString(PREFERRED_LANGUAGE).uppercase()),
                supportedLanguages = (0 until supportedLanguagesArray.length()).map {
                    Language.valueOf(supportedLanguagesArray.getString(it).uppercase())
                }
            )
        }
    }
}