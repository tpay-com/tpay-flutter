import Tpay

final class TransactionConfiguration {

    // MARK: - Constants

    private enum Defaults {
        static let successRedirectUrl = URL(string: "https://secure.tpay.com/mobile-sdk/success/")!
        static let errorRedirectUrl = URL(string: "https://secure.tpay.com/mobile-sdk/error/")!
    }

    // MARK: - API

    static func single(transactionConfiguration: String) -> Transaction? {
        guard let trancationData = transactionConfiguration.data(using: .utf8),
              let signleTransaction = try? JSONDecoder().decode(T.SingleTransaction.self, from: trancationData) else {
            return nil
        }

        let payerContext = makeTransactionPayerContext(from: signleTransaction)

        return SingleTransaction(amount: signleTransaction.amount, description: signleTransaction.description, payerContext: payerContext)
    }

    static func cardTokenTransaction(transactionConfiguration: String) -> Transaction? {
        guard let trancationData = transactionConfiguration.data(using: .utf8),
              let tokenPayment = try? JSONDecoder().decode(T.TokenPayment.self, from: trancationData) else {
            return nil
        }
        let payerContext = makeTokenPayerContext(from: tokenPayment)
        return SingleTransaction(amount: tokenPayment.amount, description: tokenPayment.description, payerContext: payerContext)
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
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     card: card,
                     cardToken: cardToken,
                     callbacks: callbacks)
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
                     payerContext: .init(payer: payer),
                     token: blikPayment.code,
                     alias: blikPayment.alias?.value,
                     paymentChannel: paymentChannel,
                     callbacks: callbacks)
    }

    static func bankPayment(bankPaymentConfiguration: String, paymentChannels: [Headless.Models.PaymentChannel]) -> BankPayment? {
        guard let bankPaymentData = bankPaymentConfiguration.data(using: .utf8),
              let bankPayment = try? JSONDecoder().decode(T.BankPayment.self, from: bankPaymentData),
              let payer = makePayer(from: bankPayment.payer),
              let paymentChannel = paymentChannels.first(where: { $0.paymentKind == .pbl }) else {
            return nil
        }

        let callbacks = makeCallbacksConfiguration(from: bankPayment.callbacks)

        return .init(amount: bankPayment.paymentDetails.amount,
                     description: bankPayment.paymentDetails.description,
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     callbacks: callbacks)
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
                     payerContext: .init(payer: payer),
                     paymentChannel: paymentChannel,
                     token: digitalWalletPayment.applePayToken,
                     callbacks: callbacks)
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

    private static func makeTransactionPayerContext(from signleTransaction: T.SingleTransaction) -> PayerContext? {
        guard let payerContext = signleTransaction.payerContext else { return nil }

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
                     notificationsUrl: callbacks.notifications.flatMap { URL(string: $0.url) })
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
