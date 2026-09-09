extension Transportation.Merchant {

    struct Authorization: Decodable {

        // MARK: - Properties

        let clientId: String
        let clientSecret: String
    }
}
