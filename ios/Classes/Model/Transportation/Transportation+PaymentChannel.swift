extension Transportation {

    struct PaymentChannel: Encodable {

        // MARK: - Properties

        let id: String
        let name: String
        let imageUrl: String?
        let constraints: [Constraint]?

        struct Constraint: Encodable {

            // MARK: - Properties

            let type: String
            let minimum: Double?
            let maximum: Double?
        }
    }
}
