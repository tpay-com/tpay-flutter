extension Transportation {

    struct PaymentMethods: Decodable {

        // MARK: - Properties

        let methods: [String]
        let wallets: [String]?
    }
}
