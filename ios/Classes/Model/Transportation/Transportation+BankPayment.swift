extension Transportation {

    struct BankPayment: Decodable {

        // MARK: - Properties

        let groupId: String
        let bankName: String
        let paymentDetails: PaymentDetails
        let payer: Payer
    }
}
