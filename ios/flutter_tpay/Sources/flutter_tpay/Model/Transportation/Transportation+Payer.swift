extension Transportation {

    struct Payer: Decodable {

        // MARK: - Properties

        let name: String
        let email: String
        let phone: String?
        let address: Address?
    }
}
