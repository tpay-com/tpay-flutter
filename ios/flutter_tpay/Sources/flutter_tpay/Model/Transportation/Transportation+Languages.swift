extension Transportation {

    struct Languages: Decodable {

        // MARK: - Properties

        let preferredLanguage: String?
        let supportedLanguages: [String]?
    }
}
