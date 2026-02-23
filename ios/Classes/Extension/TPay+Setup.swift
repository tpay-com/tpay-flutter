import Tpay

extension TpayModule {

    // MARK: - API

    static func setup(merchant: Merchant,
                      paymentMethods: [PaymentMethod]?,
                      preferredLanguage: Language?,
                      supportedLanguages: [Language],
                      sslCertificatesProvider: SSLCertificatesProvider?,
                      detailsProvider: MerchantDetailsProvider) throws {
        try TpayModule.configure(
            compatibility: .flutter,
            sdkVersionName: getFlutterTpayVersion()
        )

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

private extension TpayModule {

    static func getFlutterTpayVersion() -> String? {
        if let bundle = Bundle(identifier: "org.cocoapods.flutter-tpay") ??
                        Bundle.allBundles.first(where: { $0.bundleURL.lastPathComponent.contains("flutter_tpay") }) {
            return bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        }
        return nil
    }
}
