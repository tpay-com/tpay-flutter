package com.tpay.model.screenless

import org.json.JSONObject

data class ExpirationDate(val month: String, val year: String) {
    override fun toString(): String {
        return "$month$SEPARATOR$year"
    }

    companion object {
        private const val MONTH = "month"
        private const val YEAR = "year"
        private const val SEPARATOR = "/"

        fun fromJson(jsonObject: JSONObject): ExpirationDate {
            return ExpirationDate(
                month = jsonObject.getString(MONTH),
                year = jsonObject.getString(YEAR)
            )
        }
    }
}