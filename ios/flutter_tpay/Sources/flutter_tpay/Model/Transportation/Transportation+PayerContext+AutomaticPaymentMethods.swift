extension Transportation.PayerContext {

    struct AutomaticPaymentMethods: Decodable {

        // MARK: - Properties

        let blikAlias: BlikAlias?
        let tokenizedCards: [T.CardToken]?
    }
}
