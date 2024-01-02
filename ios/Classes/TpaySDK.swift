import Tpay

final class TpaySDK {

    // MARK: - Properties

    private let paymentPresentation = PaymentPresentation()
    private let tokenCardPresentation = CardTokenPresentation()
    private let addCardPresentation = AddCardPresentation()

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

    func singleTransactionPayment(_ json: String, resolve: @escaping (String) -> Void) {
        guard let singleTransaction = TransactionConfiguration.single(transactionConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        paymentPresentation.paymentResult = { result in resolve(result) }

        do {
            try paymentPresentation.presentPayment(for: singleTransaction)
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
            try tokenCardPresentation.presentPayment(for: singleTransaction)
        } catch {
            resolve(ConfigurationResult.configurationFailure(error: error).toJson())
        }
    }

    func addCard(_ json: String, resolve: @escaping (String) -> Void) {
        guard let payer = TransactionConfiguration.addCard(tokenisationConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        addCardPresentation.addCardResult = { result in resolve(result) }

        do {
            try addCardPresentation.presentAddCard(for: payer)
        } catch {
            resolve(ConfigurationResult.configurationFailure(error: error).toJson())
        }
    }

    func paymentWithCard(_ json: String, resolve: @escaping (String) -> Void) {
        guard let cardPayment = TransactionConfiguration.cardPayment(cardPaymentConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        TpayModule.payment(with: cardPayment.cardPayment, amount: cardPayment.amount, payer: cardPayment.payer) { result in
            switch result {
            case let .success(transactionId):
                resolve(ConfigurationResult.cardPaymentCompleted(transactionId: transactionId).toJson())
            case let .failure(error):
                resolve(ConfigurationResult.cardPaymentFailure(error: error).toJson())
            }
        }
    }

    func paymentWithBlik(_ json: String, resolve: @escaping (String) -> Void) {
        guard let blikPayment = TransactionConfiguration.blikPayment(blikPaymentConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        TpayModule.payment(with: blikPayment.blikData, amount: blikPayment.amount, payer: blikPayment.payer) { result in
            switch result {
            case let .success(transactionId):
                resolve(ConfigurationResult.blikPaymentCompleted(transactionId: transactionId).toJson())
            case let .failure(error):
                resolve(ConfigurationResult.blikPaymentFailure(error: error).toJson())
            }
        }
    }

    func paymentWithBank(_ json: String, resolve: @escaping (String) -> Void) {
        guard let bankPayment = TransactionConfiguration.bankPayment(bankPaymentConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        TpayModule.payment(with: bankPayment.bankData, amount: bankPayment.amount, payer: bankPayment.payer) { result in
            switch result {
            case let .success(transactionURL):
                resolve(ConfigurationResult.bankPaymentCompleted(transactionURL: transactionURL).toJson())
            case let .failure(error):
                resolve(ConfigurationResult.bankPaymentFailure(error: error).toJson())
            }
        }
    }

    func paymentWithDigitalWallet(_ json: String, resolve: @escaping (String) -> Void) {
        guard let digitalWalletPayment = TransactionConfiguration.digitalWalletPayment(digitalWalletPaymentConfiguration: json) else {
            resolve(ConfigurationResult.configurationFailure().toJson())
            return
        }

        TpayModule.payment(with: digitalWalletPayment.walletData, amount: digitalWalletPayment.amount, payer: digitalWalletPayment.payer) { result in
            switch result {
            case let .success(transactionId):
                resolve(ConfigurationResult.digitalWalletPaymentCompleted(transactionId: transactionId).toJson())
            case let .failure(error):
                resolve(ConfigurationResult.digitalWalletPaymentFailure(error: error).toJson())
            }
        }
    }

    func getPaymentMethods(resolve: @escaping (String) -> Void) {
        TpayModule.getPaymentMethods { result in
            switch result {
            case let .success(paymentMethods):
                resolve(PaymentMethodsConfiguration.configuration(for: paymentMethods))
            case let .failure(error):
                resolve(ConfigurationResult.paymentMethodsError(error: error).toJson())
            }
        }
    }
}
