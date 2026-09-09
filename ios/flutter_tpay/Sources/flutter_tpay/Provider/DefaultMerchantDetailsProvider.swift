import Tpay

final class DefaultMerchantDetailsProvider: MerchantDetailsProvider {

    // MARK: - Properties

    private let merchantDisplayName: [Language: String]
    private let merchantHeadquarters: [Language: String]
    private let regulationsLink: [Language: URL]

    // MARK: - Initializers

    init(merchantDisplayName: [Language: String], merchantHeadquarters: [Language: String], regulationsLink: [Language: URL]) {
        self.merchantDisplayName = merchantDisplayName
        self.merchantHeadquarters = merchantHeadquarters
        self.regulationsLink = regulationsLink
    }

    // MARK: - API

    func merchantDisplayName(for language: Language) -> String {
        return merchantDisplayName[language]!
    }

    func merchantHeadquarters(for language: Language) -> String? {
        return merchantHeadquarters[language]
    }

    func regulationsLink(for language: Language) -> URL {
        return regulationsLink[language]!
    }
}
