extension Transportation {

    struct PaymentDetails: Decodable {

        // MARK: - Properties

        let amount: Double
        let description: String
        let hiddenDescription: String?
    }
}
