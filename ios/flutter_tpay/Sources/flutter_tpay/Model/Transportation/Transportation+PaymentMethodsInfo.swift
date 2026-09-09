extension Transportation {

    struct PaymentMethodsInfo: Encodable {

        // MARK: - Properties

        let isBLIKPaymentAvailable: Bool
        let isCreditCardPaymentAvailable: Bool
        let availableTransferMethods: [BankPayment.Bank]
        let availableDigitalWallets: [String]
    }
}
