import Tpay

extension Transportation {

    enum Environment: String {

        // MARK: - Cases

        case production
        case sandbox

        // MARK: - Properties

        var tpayEnvironment: Tpay.Merchant.Environment {
            switch self {
            case .production:
                return .production
            case .sandbox:
                return .sandbox
            }
        }
    }
}
