extension Transportation {

    struct MerchantConfiguration: Decodable {

        // MARK: - Properties

        let merchant: Merchant
        let languages: Languages?
        let merchantDetails: MerchantDetails
        let paymentMethods: PaymentMethods?
        let singleTransaction: Bool?
    }
}
