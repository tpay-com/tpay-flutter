extension Transportation {

    struct BlikPayment: Decodable {

        // MARK: - Properties

        let code: String?
        let alias: Alias?
        let paymentDetails: PaymentDetails
        let payer: Payer
    }
}
