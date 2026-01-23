import Tpay

final class TransactionConfiguration {

    // MARK: - Constants

    private enum Defaults {
        static let successRedirectUrl = URL(string: "https://secure.tpay.com/mobile-sdk/success/")!
        static let errorRedirectUrl = URL(string: "https://secure.tpay.com/mobile-sdk/error/")!
    }

    // MARK: - API

    static func single(transactionConfiguration: String) -> SingleTransaction? {
        guard let transactionData = transactionConfiguration.data(using: .utf8),
              let singleTransaction = try? JSONDecoder().decode(T.SingleTransaction.self, from: transactionData) else {
            return nil
        }

        let payerContext = makeTransactionPayerContext(from: singleTransaction)
        let callbacks = makeCallbacksConfiguration(from: singleTransaction.notifications)

        let baseTransaction = Tpay.SingleTransaction(amount: singleTransaction.amount, description: singleTransaction.description, hiddenDescription: singleTransaction.hiddenDescription, payerContext: payerContext)
        let wrappedSingleTransaction = SingleTransaction(singleTransaction: baseTransaction, callbacks: callbacks)
        return wrappedSingleTransaction;
    }

    static func cardTokenTransaction(transactionConfiguration: String) -> SingleTransaction? {
        guard let transactionData = transactionConfiguration.data(using: .utf8),
              let tokenPayment = try? JSONDecoder().decode(T.TokenPayment.self, from: transactionData) else {
            return nil
        }

        let payerContext = makeTokenPayerContext(from: tokenPayment)
        let callbacks = makeCallbacksConfiguration(from: tokenPayment.notifications)

        let baseTransaction = Tpay.SingleTransaction(amount: tokenPayment.amount, description: tokenPayment.description, hiddenDescription: tokenPayment.hiddenDescription, payerContext: payerContext)
        let wrappedSingleTransaction = SingleTransaction(singleTransaction: baseTransaction, callbacks: callbacks)
        return wrappedSingleTransaction;
    }
    
    static func addCard(tokenisationConfiguration: String) -> TokenizationData? {
        guard let tokenisationData = tokenisationConfiguration.data(using: .utf8),
              let tokenisation = try? JSONDecoder().decode(T.Tokenisation.self, from: tokenisationData),
              let payer = makePayer(from: tokenisation.payer)
        else {
            return nil
        }
        return TokenizationData.init(payer: payer, notificationUrl: tokenisation.notificationUrl, successRedirectUrl: tokenisation.successRedirectUrl, errorRedirectUrl: tokenisation.errorRedirectUrl)
    }

    static func cardPayment(cardPaymentConfiguration: String, paymentChannels: [Headless.Models.PaymentChannel]) -> CardPayment? {
        guard let cardPaymentData = cardPaymentConfiguration.data(using: .utf8),
              let cardPayment = try? JSONDecoder().decode(T.CardPayment.self, from: cardPaymentData),
              let payer = makePayer(from: cardPayment.payer),
              let paymentChannel = paymentChannels.first(where: { $0.paymentKind == .card }) else {
            return nil
        }

        let callbacks = makeCallbacksConfiguration(from: cardPayment.callbacks)

        let card = cardPayment.creditCard.flatMap { creditCard -> Headless.Models.Card? in
            Headless.Models.Card(number: creditCard.number, expiryDate: .init(month: creditCard.expiryDate.month, year: creditCard.expiryDate.year), securityCode: creditCard.securityCode, shouldTokenize: creditCard.config.shouldSave)
        }

        let cardToken = cardPayment.creditCardToken.flatMap { token -> Headless.Models.CardToken? in
            try? Headless.Models.CardToken(token: token, cardTail: "1234", brand: .other(""))
        }

        return .init(amount: cardPayment.paymentDetails.amount,
                     description: cardPayment.paymentDetails.description,
                     hiddenDescription: cardPayment.paymentDetails.hiddenDescription,
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     card: card,
                     cardToken: cardToken,
                     callbacks: callbacks
        )
    }

    static func blikPayment(blikPaymentConfiguration: String, paymentChannels: [Headless.Models.PaymentChannel]) -> BlikPayment? {
        guard let blikPaymentData = blikPaymentConfiguration.data(using: .utf8),
              let blikPayment = try? JSONDecoder().decode(T.BlikPayment.self, from: blikPaymentData),
              let payer = makePayer(from: blikPayment.payer),
              let paymentChannel = paymentChannels.first(where: { $0.paymentKind == .blik }) else {
            return nil
        }

        let callbacks = makeCallbacksConfiguration(from: blikPayment.callbacks)

        return .init(amount: blikPayment.paymentDetails.amount,
                     description: blikPayment.paymentDetails.description,
                     hiddenDescription: blikPayment.paymentDetails.hiddenDescription,
                     payerContext: .init(payer: payer),
                     token: blikPayment.code,
                     alias: blikPayment.alias?.value,
                     paymentChannel: paymentChannel,
                     callbacks: callbacks
        )
    }

    static func bankPayment(bankPaymentConfiguration: String, paymentChannels: [Headless.Models.PaymentChannel]) throws -> BankPayment? {
        guard let bankPaymentData = bankPaymentConfiguration.data(using: .utf8),
              let bankPayment = try? JSONDecoder().decode(T.BankPayment.self, from: bankPaymentData),
              let payer = makePayer(from: bankPayment.payer) else {
            return nil
        }
        
        guard let paymentChannel = paymentChannels.first(where: { $0.has(channelId: bankPayment.channelId) }) else {
            throw PaymentChannelError.unknownPaymentChannel
        }

        let callbacks = makeCallbacksConfiguration(from: bankPayment.callbacks)

        return .init(amount: bankPayment.paymentDetails.amount,
                     description: bankPayment.paymentDetails.description,
                     hiddenDescription: bankPayment.paymentDetails.hiddenDescription,
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     callbacks: callbacks
        )
    }

    static func digitalWalletPayment(digitalWalletPaymentConfiguration: String, paymentChannels: [Headless.Models.PaymentChannel]) -> DigitalWalletPayment? {
        guard let digitalWalletPaymentData = digitalWalletPaymentConfiguration.data(using: .utf8),
              let digitalWalletPayment = try? JSONDecoder().decode(T.DigitalWalletPayment.self, from: digitalWalletPaymentData),
              let payer = makePayer(from: digitalWalletPayment.payer),
              let paymentChannel = paymentChannels.first(where: { $0.paymentKind == .applePay }) else {
            return nil
        }

        let callbacks = makeCallbacksConfiguration(from: digitalWalletPayment.callbacks)

        return .init(amount: digitalWalletPayment.paymentDetails.amount,
                     description: digitalWalletPayment.paymentDetails.description,
                     hiddenDescription: digitalWalletPayment.paymentDetails.hiddenDescription,
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     token: digitalWalletPayment.applePayToken,
                     callbacks: callbacks
        )
    }
    
    static func payPoPayment(payPoPaymentConfiguration: String, paymentChannels: [Headless.Models.PaymentChannel]) -> PayPoPayment? {
        guard let payPoData = payPoPaymentConfiguration.data(using: .utf8),
              let payPoPayment = try? JSONDecoder().decode(T.PayPoPayment.self, from: payPoData),
              let payer = makePayer(from: payPoPayment.payer),
              let paymentChannel = paymentChannels.first(where: { $0.paymentKind == .payPo }) else {
            return nil
        }

        let callbacks = makeCallbacksConfiguration(from: payPoPayment.callbacks)

        return .init(amount: payPoPayment.paymentDetails.amount,
                     description: payPoPayment.paymentDetails.description,
                     hiddenDescription: payPoPayment.paymentDetails.hiddenDescription,
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     callbacks: callbacks
        )
    }

    static func continuePayment(continuePaymentConfiguration: String) -> ContinuePayment? {
        guard let continuePaymentData = continuePaymentConfiguration.data(using: .utf8),
              let continuePayment = try? JSONDecoder().decode(T.ContinuePayment.self, from: continuePaymentData) else {
            return nil
        }

        return .init(id: continuePayment.transactionId, alias: continuePayment.blikAlias.value, ambiguousAlias: continuePayment.ambiguousBlikAlias)
    }

    static func makeAliases(from aliases: [Headless.Models.Blik.AmbiguousBlikAlias.Application]) -> [T.AmbiguousAlias] {
        aliases.map { T.AmbiguousAlias(name: $0.name, code: $0.key) }
    }

    // MARK: - Private

    private static func makeTransactionPayerContext(from singleTransaction: T.SingleTransaction) -> PayerContext? {
        guard let payerContext = singleTransaction.payerContext else { return nil }

        let payer = makePayer(from: payerContext.payer)
        let blikAllias = payerContext.automaticPaymentMethods?.blikAlias?.value
        let registredBlikAlias = blikAllias != nil ? RegisteredBlikAlias(value: .uid(blikAllias!)) : nil
        let tokenizedCards = payerContext.automaticPaymentMethods?.tokenizedCards?.compactMap { makeCardToken(from: $0) }

        return .init(payer: payer, automaticPaymentMethods: .init(registeredBlikAlias: registredBlikAlias, tokenizedCards: tokenizedCards))
    }

    private static func makeTokenPayerContext(from tokenPayment: T.TokenPayment) -> PayerContext {
        let payer = makePayer(from: tokenPayment.payer)
        let tokenizedCard = makeCardToken(from: tokenPayment)

        return .init(payer: payer, automaticPaymentMethods: .init(tokenizedCards: tokenizedCard != nil ? [tokenizedCard!] : []))
    }

    private static func makePayer(from contexPayer: T.Payer?) -> Payer? {
        guard let contexPayer = contexPayer else { return nil }

        let address = makeAddress(from: contexPayer.address)

        return .init(name: contexPayer.name, email: contexPayer.email, phone: contexPayer.phone, address: address)
    }

    private static func makeAddress(from contextAddress: T.Payer.Address?) -> Address? {
        guard let contextAddress = contextAddress else { return nil }

        return .init(address: contextAddress.address,
                     city: contextAddress.city,
                     country: contextAddress.countryCode,
                     postalCode: contextAddress.postalCode)
    }

    private static func makeCardToken(from tokenPayment: T.TokenPayment) -> CardToken? {
        return try? .init(token: tokenPayment.cardToken, cardTail: "1234", brand: .other(""))
    }

    private static func makeCardToken(from tokenData: T.CardToken?) -> CardToken? {
        guard let tokenData = tokenData else { return nil }
        return try? .init(token: tokenData.token, cardTail: tokenData.cardTail, brand: makeCardBrand(from: tokenData.brand))
    }

    private static func makeCallbacksConfiguration(from callbacks: T.Callbacks) -> CallbacksConfiguration {
        return .init(successRedirectUrl: URL(string: callbacks.redirects?.successUrl ?? Defaults.successRedirectUrl.absoluteString) ?? Defaults.successRedirectUrl,
                     errorRedirectUrl: URL(string: callbacks.redirects?.errorUrl ?? Defaults.errorRedirectUrl.absoluteString) ?? Defaults.errorRedirectUrl,
                     notificationsUrl: callbacks.notifications.flatMap { URL(string: $0.url) },
                     notificationEmail: callbacks.notifications.flatMap { $0.email }
        )
    }

    private static func makeCallbacksConfiguration(from notifications: T.Callbacks.Notifications?) -> CallbacksConfiguration {
        return .init(successRedirectUrl: URL(string: Defaults.successRedirectUrl.absoluteString) ?? Defaults.successRedirectUrl,
                     errorRedirectUrl: URL(string: Defaults.errorRedirectUrl.absoluteString) ?? Defaults.errorRedirectUrl,
                     notificationsUrl: notifications.flatMap { URL(string: $0.url) },
                     notificationEmail: notifications.flatMap { $0.email }
        )
    }

    private static func makeCardBrand(from brand: String) -> CardToken.Brand {
        switch brand {
        case "visa":
            return CardToken.Brand.visa
        case "mastercard":
            return CardToken.Brand.mastercard
        default:
            return CardToken.Brand.other(brand)
        }
    }
}
