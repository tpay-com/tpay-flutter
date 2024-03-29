extension Transportation {

    struct DigitalWalletPayment: Decodable {

        // MARK: - Properties

        let applePayToken: String
        let paymentDetails: PaymentDetails
        let payer: T.Payer
        let callbacks: Callbacks
    }
}
