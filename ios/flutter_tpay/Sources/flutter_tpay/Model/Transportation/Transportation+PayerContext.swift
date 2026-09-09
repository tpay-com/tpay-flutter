extension Transportation {

    struct PayerContext: Decodable {

        // MARK: - Properties

        let payer: Payer?
        let automaticPaymentMethods: AutomaticPaymentMethods?
    }
}
