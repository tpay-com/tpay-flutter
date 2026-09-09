extension Transportation {

    struct CardDetails: Decodable {

        // MARK: - Properties

        let number: String
        let expiryDate: ExpiryDate
        let securityCode: String
        let config: Configuration
    }
}
