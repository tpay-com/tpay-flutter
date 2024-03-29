extension Transportation.Callbacks {

    struct Redirects: Decodable {

        // MARK: - Properties

        let successUrl: String
        let errorUrl: String
    }
}
