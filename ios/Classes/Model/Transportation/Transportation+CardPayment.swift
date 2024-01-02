extension Transportation {

    struct CardPayment: Decodable {

        // MARK: - Properties

        let cardData: CardDetails?
        let creditCardToken: CardToken?
        let paymentDetails: PaymentDetails
        let payer: Payer
    }
}
