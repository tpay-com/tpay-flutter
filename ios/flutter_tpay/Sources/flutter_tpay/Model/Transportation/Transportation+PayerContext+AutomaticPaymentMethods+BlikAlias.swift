extension Transportation.PayerContext.AutomaticPaymentMethods {

    struct BlikAlias: Decodable {

        // MARK: - Properties

        let value: String
        let isRegistered: Bool
        let label: String?
    }
}
