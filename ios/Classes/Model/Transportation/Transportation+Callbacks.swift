extension Transportation {

    struct Callbacks: Decodable {

        // MARK: - Properties

        let redirects: Redirects?
        let notifications: Notifications?
    }
}
