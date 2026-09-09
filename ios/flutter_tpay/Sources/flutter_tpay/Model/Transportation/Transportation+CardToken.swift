extension Transportation {

    struct CardToken: Decodable {

        // MARK: - Properties

        let token: String
        let cardTail: String
        let brand: String
    }
}
