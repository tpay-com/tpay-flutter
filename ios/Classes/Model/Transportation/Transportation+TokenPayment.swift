extension Transportation {

    struct TokenPayment: Decodable {

        // MARK: - Properties

        let cardToken: CardToken
        let paymentDetails: PaymentDetails
        let payer: Payer?
    }
}
