import Tpay

final class TransactionConfiguration {

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

        return SingleTransaction(amount: tokenPayment.paymentDetails.amount, description: tokenPayment.paymentDetails.description, payerContext: payerContext)
    }
    
    static func addCard(tokenisationConfiguration: String) -> Payer? {
        guard let tokenisationData = tokenisationConfiguration.data(using: .utf8),
              let tokenisation = try? JSONDecoder().decode(T.Tokenisation.self, from: tokenisationData),
              let payer = makePayer(from: tokenisation.payer) else {
            return nil
        }
        return payer
    }

    static func cardPayment(cardPaymentConfiguration: String) -> CardPayment? {
        guard let cardPaymentCata = cardPaymentConfiguration.data(using: .utf8),
              let cardPayment = try? JSONDecoder().decode(T.CardPayment.self, from: cardPaymentCata),
              let payer = makePayer(from: cardPayment.payer) else {
            return nil
        }

        let card = makeCardDetails(from: cardPayment.cardData)
        let cardToken = makeCardToken(from: cardPayment.creditCardToken)
//        let cardData = PaymentData.Card(card: card, token: cardToken)
//
//        return .init(cardPayment: cardData, amount: cardPayment.paymentDetails.amount, payer: payer)
        #warning("TODO: - Update Tpay ios repo")
        return nil
    }

    static func blikPayment(blikPaymentConfiguration: String) -> BlikPayment? {
        guard let blikPaymentData = blikPaymentConfiguration.data(using: .utf8),
              let blikPayment = try? JSONDecoder().decode(T.BlikPayment.self, from: blikPaymentData),
              let blikData = makeBlikData(from: blikPayment),
              let payer = makePayer(from: blikPayment.payer) else {
            return nil
        }
        return .init(blikData: blikData, amount: blikPayment.paymentDetails.amount, payer: payer)
    }

    static func bankPayment(bankPaymentConfiguration: String) -> BankPayment? {
        guard let bankPaymentData = bankPaymentConfiguration.data(using: .utf8),
              let bankPayment = try? JSONDecoder().decode(T.BankPayment.self, from: bankPaymentData),
              let payer = makePayer(from: bankPayment.payer) else {
            return nil
        }
        #warning("TODO: - Update Tpay ios repo")
//
//        let bankData = makeBankData(from: bankPayment)
//        return .init(bankData: bankData, amount: bankPayment.paymentDetails.amount, payer: payer)
        return nil
    }

    static func digitalWalletPayment(digitalWalletPaymentConfiguration: String) -> DigitalWalletPayment? {
        guard let digitalWalletPaymentData = digitalWalletPaymentConfiguration.data(using: .utf8),
              let digitalWalletPayment = try? JSONDecoder().decode(T.DigitalWalletPayment.self, from: digitalWalletPaymentData),
              let payer = makePayer(from: digitalWalletPayment.payer) else {
            return nil
        }

//        let walletData = makeWalletData(from: digitalWalletPayment.applePayToken)
//
//        return .init(walletData: walletData, amount: amount, payer: payer)
        #warning("TODO: - Update Tpay ios repo")
        return nil
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
        let tokenizedCard = makeCardToken(from: tokenPayment.cardToken)

        return .init(payer: payer, automaticPaymentMethods: .init(tokenizedCards: tokenizedCard != nil ? [tokenizedCard!] : []))
    }

    private static func makePayer(from contexPayer: T.Payer?) -> Payer? {
        guard let contexPayer = contexPayer else { return nil }

        let address = makeAddress(from: contexPayer.address)

        return .init(name: contexPayer.name, email: contexPayer.email, address: address)
    }

    private static func makeAddress(from contextAddress: T.Payer.Address?) -> Address? {
        guard let contextAddress = contextAddress else { return nil }

        return .init(address: contextAddress.address,
                     city: contextAddress.city,
                     country: contextAddress.country,
                     postalCode: contextAddress.postalCode)
    }

    private static func makeCardDetails(from cardDetails: T.CardDetails?) -> PaymentData.Card.CardDetails? {
        guard let cardDetails = cardDetails else { return nil }
        #warning("TODO: - Update Tpay ios repo")
//        return .init(number: cardDetails.number,
//                     expiryDate: .init(month: cardDetails.expiryDate.month, year: cardDetails.expiryDate.year),
//                     securityCode: cardDetails.securityCode,
//                     shouldSave: cardDetails.config.shouldSave)
        return nil
    }

    private static func makeCardToken(from _: T.CardToken?) -> CardToken? {
        #warning("TODO: - Update Tpay ios repo")
//        guard let tokenData = tokenData, let brand = CardToken.Brand(rawValue: tokenData.brand) else { return nil }
//        return try? .init(token: tokenData.token, cardTail: tokenData.cardTail, brand: brand)
        return nil
    }

    private static func makeBlikData(from blikPayment: T.BlikPayment) -> PaymentData.Blik? {
        let alias = blikPayment.alias?.value != nil ? RegisteredBlikAlias(value: .uid(blikPayment.alias!.value)) : nil
        return .init(blikToken: blikPayment.code, aliases: alias)
    }

    #warning("TODO: - Update Tpay ios repo")
//    private static func makeBankData(from bankData: T.BankPayment) -> PaymentData.Bank {
//        return .init(id: bankData.groupId, name: bankData.bankName, imageUrl: nil)
//    }
//
//    private static func makeWalletData(from token: String) -> PaymentData.DigitalWallet {
//        return .applePay(.init(token: token))
//    }
}
