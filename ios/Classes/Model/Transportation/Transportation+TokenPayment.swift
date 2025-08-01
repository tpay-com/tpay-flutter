extension Transportation {

    struct TokenPayment: Decodable {

        // MARK: - Properties

        let cardToken: String
        let amount: Double
        let description: String
        let hiddenDescription: String?
        let payer: Payer?
    }
}
