extension Transportation.CardDetails {

    struct ExpiryDate: Decodable {

        // MARK: - Properties

        let month: Int
        let year: Int
    }
}
