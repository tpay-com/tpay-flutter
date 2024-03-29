extension Transportation {

    struct PaymentMethods: Decodable {

        // MARK: - Properties

        let methods: [String]
        let installmentPayments: [String]?
        let wallets: [String]?
    }
}
