extension Transportation {

    struct Tokenisation: Decodable {

        // MARK: - Properties

        let payer: Payer?
        let notificationUrl: String
        let errorRedirectUrl: String?
        let successRedirectUrl: String?
    }
}
