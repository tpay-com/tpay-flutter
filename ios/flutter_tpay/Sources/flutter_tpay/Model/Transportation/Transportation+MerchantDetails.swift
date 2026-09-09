extension Transportation {

    struct MerchantDetails: Decodable {

        // MARK: - Properties

        let merchantDisplayName: [Detail]?
        let merchantHeadquarters: [Detail]?
        let regulations: [Detail]?
    }
}
