extension Transportation {

    struct SingleTransaction: Decodable {

        // MARK: - Properties

        let amount: Double
        let description: String
        let hiddenDescription: String?
        let payerContext: PayerContext?
    }
}
