import Tpay

final class TpaySDK {

    // MARK: - Properties

    private let paymentPresentation = PaymentPresentation()
    private let tokenCardPresentation = CardTokenPresentation()
    private let addCardPresentation = AddCardPresentation()

    private var blikPayments: [Headless.Models.BlikPaymentResultWithAmbiguousAliases] = []

    // MARK: - API

    func configure(_ json: String) -> String {
        guard let configuration = MerchantConfiguration(configuration: json),
              let merchant = configuration.merchant() else {
            return ConfigurationResult.configurationFailure().toJson()
        }

        let preferredLanguage = configuration.preferredLanguage()
        let paymentMethods = configuration.paymentMethods()
        let supportedLanguages = configuration.supportedLanguage()
        let sslCertificatesProvider = configuration.sslCertificatesProvider()
        let detailsProvider = configuration.detailsProvider()

        do {
            try TpayModule.setup(merchant: merchant,
                                 paymentMethods: paymentMethods,
                                 preferredLanguage: preferredLanguage,
                                 supportedLanguages: supportedLanguages,
                                 sslCertificatesProvider: sslCertificatesProvider,
                                 detailsProvider: detailsProvider)
            return ConfigurationResult.configurationValid().toJson()
        } catch {
            return ConfigurationResult.configurationFailure(error: error).toJson()
        }
    }

    func singleTransactionPayment(_ json: String, resolve: @escaping (String) -> Void, resolveIntermediate: @escaping (String) -> Void) {
        guard let singleTransaction = TransactionConfiguration.single(transactionConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        paymentPresentation.paymentResult = { result in resolve(result) }
        paymentPresentation.paymentIntermediateResult = { result in resolveIntermediate(result) }

        do {
            try TpayModule.configure(callbacks: singleTransaction.callbacks)
            try paymentPresentation.presentPayment(for: singleTransaction.singleTransaction)
        } catch {
            resolve(ConfigurationResult.configurationFailure(error: error).toJson())
        }
    }

    func cardTokenTransaction(_ json: String, resolve: @escaping (String) -> Void) {
        guard let singleTransaction = TransactionConfiguration.cardTokenTransaction(transactionConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        tokenCardPresentation.cardTokenPaymentResult = { result in resolve(result) }

        do {
            try TpayModule.configure(callbacks: singleTransaction.callbacks)
            try tokenCardPresentation.presentPayment(for: singleTransaction.singleTransaction)
        } catch {
            resolve(ConfigurationResult.configurationFailure(error: error).toJson())
        }
    }

    func addCard(_ json: String, resolve: @escaping (String) -> Void) {
        guard let tokenizationData = TransactionConfiguration.addCard(tokenisationConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        addCardPresentation.addCardResult = { result in resolve(result) }

        do {
            try TpayModule.configure(callbacks: CallbacksConfiguration.init(successRedirectUrl: tokenizationData.successRedirectUrl != nil ? URL(string: tokenizationData.successRedirectUrl!) : nil, errorRedirectUrl: tokenizationData.errorRedirectUrl != nil ? URL(string: tokenizationData.errorRedirectUrl!) : nil, notificationsUrl: URL(string: tokenizationData.notificationUrl)))
            
            try addCardPresentation.presentAddCard(for: tokenizationData.payer)
        } catch {
            resolve(ConfigurationResult.configurationFailure(error: error).toJson())
        }
    }

    func paymentWithCard(_ json: String, resolve: @escaping (String) -> Void) {
        Headless.getAvailablePaymentChannels { [weak self] result in
            switch result {
            case let .success(paymentChannels):
                self?.invokeCardPayment(json, resolve: resolve, paymentChannels: paymentChannels)
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    func paymentWithBlik(_ json: String, resolve: @escaping (String) -> Void) {
        Headless.getAvailablePaymentChannels { [weak self] result in
            switch result {
            case let .success(paymentChannels):
                self?.invokeBlikPayment(json, resolve: resolve, paymentChannels: paymentChannels)
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    func paymentWithBank(_ json: String, resolve: @escaping (String) -> Void) {
        Headless.getAvailablePaymentChannels { [weak self] result in
            switch result {
            case let .success(paymentChannels):
                self?.invokeBankPayment(json, resolve: resolve, paymentChannels: paymentChannels)
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    func paymentWithDigitalWallet(_ json: String, resolve: @escaping (String) -> Void) {
        Headless.getAvailablePaymentChannels { [weak self] result in
            switch result {
            case let .success(paymentChannels):
                self?.invokeDigitalwalletPayment(json, resolve: resolve, paymentChannels: paymentChannels)
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }
    
    func paymentWithPayPo(_ json: String, resolve: @escaping (String) -> Void) {
        Headless.getAvailablePaymentChannels { [weak self] result in
            switch result {
            case let .success(paymentChannels):
                self?.invokePayPoPayment(json, resolve: resolve, paymentChannels: paymentChannels)
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    func continuePayment(_ json: String, resolve: @escaping (String) -> Void) {
        guard let continuePayment = TransactionConfiguration.continuePayment(continuePaymentConfiguration: json),
              let blikTranscation = blikPayments.first(where: { $0.ongoingTransaction.id == continuePayment.id }),
              let application = blikTranscation.applications.first(where: { $0.key == continuePayment.ambiguousAlias.code && $0.name == continuePayment.ambiguousAlias.name }) else {
            resolve(ScreenlessResult.methodCallError().toJson())
            return
        }

        do {
            try Headless.continuePayment(for: blikTranscation.ongoingTransaction,
                                         with: .init(registeredAlias: .init(value: .uid(continuePayment.alias)),
                                                     application: application)) { result in
                switch result {
                case let .success(transaction):
                    resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
                case let .failure(error):
                    resolve(ScreenlessResult.paymentFailure(error: error).toJson())
                }
            }
        } catch {
            resolve(ScreenlessResult.paymentFailure(error: error).toJson())
        }
    }

    func getPaymentMethods(resolve: @escaping (String) -> Void) {
        Headless.getAvailablePaymentChannels { result in
            switch result {
            case let .success(paymentMethods):
                let channels = PaymentMethodsConfiguration.configuration(for: paymentMethods)
                resolve(PaymentChannelResult.configurationValid(channels: channels).toJson())
            case let .failure(error):
                resolve(PaymentChannelResult.configurationError(error: error).toJson())
            }
        }
    }

    // MARK: - Private

    private func invokeCardPayment(_ json: String, resolve: @escaping (String) -> Void, paymentChannels: [Headless.Models.PaymentChannel]) {
        do {
            guard let cardPayment = TransactionConfiguration.cardPayment(cardPaymentConfiguration: json, paymentChannels: paymentChannels) else {
                resolve(ScreenlessResult.methodCallError().toJson())
                return
            }
            try TpayModule.configure(callbacks: cardPayment.callbacks)
            if let _ = cardPayment.card {
                try invokeCardDataPayment(cardPayment: cardPayment, resolve: resolve)
            } else if let _ = cardPayment.cardToken {
                try invokeCardTokenPayment(cardPayment: cardPayment, resolve: resolve)
            } else {
                resolve(ScreenlessResult.methodCallError().toJson())
            }
        } catch {
            resolve(ScreenlessResult.paymentFailure(error: error).toJson())
        }
    }

    private func invokeCardDataPayment(cardPayment: CardPayment, resolve: @escaping (String) -> Void) throws {
        try Headless.invokePayment(for: cardPayment, using: cardPayment.paymentChannel, with: cardPayment.card!) { result in
            switch result {
            case let .success(transaction):
                resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    private func invokeCardTokenPayment(cardPayment: CardPayment, resolve: @escaping (String) -> Void) throws {
        try Headless.invokePayment(for: cardPayment, using: cardPayment.paymentChannel, with: cardPayment.cardToken!) { result in
            switch result {
            case let .success(transaction):
                resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    private func invokeBlikPayment(_ json: String, resolve: @escaping (String) -> Void, paymentChannels: [Headless.Models.PaymentChannel]) {
        guard let blikPayment = TransactionConfiguration.blikPayment(blikPaymentConfiguration: json, paymentChannels: paymentChannels) else {
            resolve(ScreenlessResult.methodCallError().toJson())
            return
        }

        do {
            try TpayModule.configure(callbacks: blikPayment.callbacks)
            if let _ = blikPayment.token {
                try invokeBlikTokenPayment(blikPayment: blikPayment, resolve: resolve)
            } else if let _ = blikPayment.alias {
                try invokeBlikAliasPayment(blikPayment: blikPayment, resolve: resolve)
            } else {
                resolve(ScreenlessResult.methodCallError().toJson())
            }
        } catch {
            resolve(ScreenlessResult.paymentFailure(error: error).toJson())
        }
    }

    private func invokeBlikTokenPayment(blikPayment: BlikPayment, resolve: @escaping (String) -> Void) throws {
        try Headless.invokePayment(for: blikPayment,
                                   using: blikPayment.paymentChannel,
                                   with: Headless.Models.Blik.Regular(token: blikPayment.token!,
                                                                      aliasToBeRegistered: blikPayment.alias.flatMap { BlikAlias(value: .uid($0)) })) { result in
            switch result {
            case let .success(transaction):
                resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    private func invokeBlikAliasPayment(blikPayment: BlikPayment, resolve: @escaping (String) -> Void) throws {
        try Headless.invokePayment(for: blikPayment,
                                   using: blikPayment.paymentChannel,
                                   with: Headless.Models.Blik.OneClick(registeredAlias: .init(value: .uid(blikPayment.alias!)))) { [weak self] result in
            switch result {
            case let .success(transaction):
                if let blikTransaction = transaction as? Headless.Models.BlikPaymentResultWithAmbiguousAliases {
                    self?.blikPayments.append(blikTransaction)
                    let aliases = TransactionConfiguration.makeAliases(from: blikTransaction.applications)
                    resolve(ScreenlessResult.ambiguousAlias(aliases: aliases, transactionId: transaction.ongoingTransaction.id).toJson())
                } else {
                    resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
                }
            case let .failure(error):
                resolve(ScreenlessResult.paymentFailure(error: error).toJson())
            }
        }
    }

    private func invokeBankPayment(_ json: String, resolve: @escaping (String) -> Void, paymentChannels: [Headless.Models.PaymentChannel]) {
        do {
            guard let bankPayment = try TransactionConfiguration.bankPayment(bankPaymentConfiguration: json, paymentChannels: paymentChannels) else {
                resolve(ScreenlessResult.methodCallError().toJson())
                return
            }
            
            try TpayModule.configure(callbacks: bankPayment.callbacks)
            try Headless.invokePayment(for: bankPayment, using: bankPayment.paymentChannel, allowedPaymentKinds: Headless.Models.PaymentKind.allCases) { result in
                switch result {
                case let .success(transaction):
                    resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
                case let .failure(error):
                    resolve(ScreenlessResult.paymentFailure(error: error).toJson())
                }
            }
        } catch {
            resolve(ScreenlessResult.paymentFailure(error: error).toJson())
        }
    }

    private func invokeDigitalwalletPayment(_ json: String, resolve: @escaping (String) -> Void, paymentChannels: [Headless.Models.PaymentChannel]) {
        guard let digitalWalletPayment = TransactionConfiguration.digitalWalletPayment(digitalWalletPaymentConfiguration: json,
                                                                                       paymentChannels: paymentChannels) else {
            resolve(ScreenlessResult.methodCallError().toJson())
            return
        }
        do {
            try TpayModule.configure(callbacks: digitalWalletPayment.callbacks)
            try Headless.invokePayment(for: digitalWalletPayment,
                                       using: digitalWalletPayment.paymentChannel,
                                       with: .init(token: digitalWalletPayment.token)) { result in
                switch result {
                case let .success(transaction):
                    resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
                case let .failure(error):
                    resolve(ScreenlessResult.paymentFailure(error: error).toJson())
                }
            }
        } catch {
            resolve(ScreenlessResult.paymentFailure(error: error).toJson())
        }
    }
    
    private func invokePayPoPayment(_ json: String, resolve: @escaping (String) -> Void, paymentChannels: [Headless.Models.PaymentChannel]) {
        guard let payPoPayment = TransactionConfiguration.payPoPayment(payPoPaymentConfiguration: json, paymentChannels: paymentChannels) else {
            resolve(ScreenlessResult.methodCallError().toJson())
            return
        }

        do {
            try TpayModule.configure(callbacks: payPoPayment.callbacks)
            try Headless.invokePayment(for: payPoPayment, using: payPoPayment.paymentChannel) { result in
                switch result {
                case let .success(transaction):
                    resolve(ScreenlessResult.paymentCreated(continueUrl: transaction.continueUrl, transactionId: transaction.ongoingTransaction.id).toJson())
                case let .failure(error):
                    resolve(ScreenlessResult.paymentFailure(error: error).toJson())
                }
            }
        } catch {
            resolve(ScreenlessResult.paymentFailure(error: error).toJson())
        }
    }
}
