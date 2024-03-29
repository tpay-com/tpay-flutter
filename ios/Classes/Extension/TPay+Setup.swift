import Tpay

extension TpayModule {

    // MARK: - API

    static func setup(merchant: Merchant,
                      paymentMethods: [PaymentMethod]?,
                      preferredLanguage: Language?,
                      supportedLanguages: [Language],
                      sslCertificatesProvider: SSLCertificatesProvider?,
                      detailsProvider: MerchantDetailsProvider) throws {
        try TpayModule.configure(merchant: merchant)
            .configure(merchantDetailsProvider: detailsProvider)

        if let preferredLanguage = preferredLanguage {
            try TpayModule.configure(preferredLanguage: preferredLanguage, supportedLanguages: supportedLanguages)
        }

        if let paymentMethods = paymentMethods {
            try TpayModule.configure(paymentMethods: paymentMethods)
        }

        if let sslCertificatesProvider = sslCertificatesProvider {
            TpayModule.configure(sslCertificatesProvider: sslCertificatesProvider)
        }

        if case let .invalid(error) = TpayModule.checkConfiguration() {
            throw error
        }
    }
}
