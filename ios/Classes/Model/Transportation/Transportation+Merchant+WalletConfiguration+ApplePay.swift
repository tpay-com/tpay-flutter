extension Transportation.Merchant.WalletConfiguration {

    struct ApplePay: Decodable {

        // MARK: - Properties

        let merchantIdentifier: String
        let countryCode: String
    }
}
