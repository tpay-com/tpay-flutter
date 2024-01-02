extension Transportation {

    struct DigitalWalletPayment: Decodable {

        // MARK: - Properties

        let applePayToken: String
        let amount: String
        let payer: T.Payer
    }
}
