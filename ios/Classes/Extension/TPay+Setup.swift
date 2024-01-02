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

    static func getPaymentMethods(completion: @escaping (Result<PaymentMethods, Error>) -> Void) {
        let group = DispatchGroup()
        var error: Error?

        var availableBanks: [PaymentData.Bank] = []
        var availableDigitalWallets: [DigitalWallet] = []
        var availablePaymentMethods: [PaymentMethod] = []

        group.enter()
        TpayModule.getAvailableBanks { result in
            switch result {
            case let .success(banks):
                availableBanks = banks
            case let .failure(banksError):
                error = banksError
            }
            group.leave()
        }

        group.enter()
        TpayModule.getAvailableDigitalWallets { result in
            switch result {
            case let .success(wallets):
                availableDigitalWallets = wallets
            case let .failure(walletsError):
                error = walletsError
            }
            group.leave()
        }

        group.enter()
        TpayModule.getAvailablePaymentMethods { result in
            switch result {
            case let .success(methods):
                availablePaymentMethods = methods
            case let .failure(methodsError):
                error = methodsError
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
                return
            }
            let paymentMethods = PaymentMethods(availableTransferMethods: availableBanks,
                                                availableDigitalWallets: availableDigitalWallets,
                                                availablePaymentMethods: availablePaymentMethods)
            completion(.success(paymentMethods))
        }
    }
}
