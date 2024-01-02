package com.tpay.model

import org.json.JSONObject

data class MerchantDetails(
    val displayNames: List<LocalizedString>,
    val merchantHeadquarters: List<LocalizedString>,
    val regulations: List<LocalizedString>,
) {
    companion object {
        private const val MERCHANT_DISPLAY_NAMES = "merchantDisplayName"
        private const val MERCHANT_CITIES = "merchantHeadquarters"
        private const val REGULATIONS = "regulations"

        fun fromJson(json: JSONObject): MerchantDetails {
            val displayNamesArray = json.getJSONArray(MERCHANT_DISPLAY_NAMES)
            val merchantHeadquartersArray = json.getJSONArray(MERCHANT_CITIES)
            val regulationsArray = json.getJSONArray(REGULATIONS)
            return MerchantDetails(
                displayNames = (0 until displayNamesArray.length()).map {
                    LocalizedString.fromJson(displayNamesArray.getJSONObject(it))
                },
                merchantHeadquarters = (0 until merchantHeadquartersArray.length()).map {
                    LocalizedString.fromJson(merchantHeadquartersArray.getJSONObject(it))
                },
                regulations = (0 until regulationsArray.length()).map {
                    LocalizedString.fromJson(regulationsArray.getJSONObject(it))
                }
            )
        }
    }
}