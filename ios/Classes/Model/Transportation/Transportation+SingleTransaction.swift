extension Transportation {

    struct SingleTransaction: Decodable {

        // MARK: - Properties

        let amount: Double
        let description: String
        let payerContext: PayerContext?
    }
}
