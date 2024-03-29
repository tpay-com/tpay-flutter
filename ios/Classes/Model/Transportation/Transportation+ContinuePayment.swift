extension Transportation {

    struct ContinuePayment: Decodable {

        // MARK: - Properties

        let transactionId: String
        let blikAlias: BlikPayment.Alias
        let ambiguousBlikAlias: AmbiguousAlias
    }
}
