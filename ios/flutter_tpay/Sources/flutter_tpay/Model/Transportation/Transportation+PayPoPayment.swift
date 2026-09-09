extension Transportation {

    struct PayPoPayment: Decodable {

        // MARK: - Properties

        let paymentDetails: PaymentDetails
        let payer: Payer
        let callbacks: Callbacks
    }
}
