package com.tpay.model

import org.json.JSONObject

data class CertificateConfiguration(
    val pinnedDomain: String,
    val publicKeyHash: String
) {
    companion object {
        private const val PINNED_DOMAIN = "pinnedDomain"
        private const val PUBLIC_KEY_HASH = "publicKeyHash"

        fun fromJson(json: JSONObject): CertificateConfiguration {
            return CertificateConfiguration(
                pinnedDomain = json.getString(PINNED_DOMAIN),
                publicKeyHash = json.getString(PUBLIC_KEY_HASH)
            )
        }
    }
}