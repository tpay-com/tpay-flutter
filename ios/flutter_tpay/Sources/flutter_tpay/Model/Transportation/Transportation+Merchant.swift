extension Transportation {

    struct Merchant: Decodable {

        // MARK: - Properties

        let authorization: Authorization
        let certificatePinningConfiguration: CertificatePinning?
        let environment: String
        let blikAliasToRegister: String?
        let walletConfiguration: WalletConfiguration?
    }
}
