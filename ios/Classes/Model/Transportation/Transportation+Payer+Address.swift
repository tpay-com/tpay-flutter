extension Transportation.Payer {

    struct Address: Decodable {

        // MARK: - Properties

        let address: String?
        let city: String?
        let country: String?
        let postalCode: String?
    }
}
