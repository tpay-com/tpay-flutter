extension Transportation {

    struct CardPayment: Decodable {

        // MARK: - Properties

        let paymentDetails: PaymentDetails
        let payer: Payer
        let callbacks: Callbacks
        let creditCard: CardDetails?
        let creditCardToken: String?
    }
}
