import Foundation

struct ScreenlessResult: Encodable {

    // MARK: - Constants

    private enum Constant {
        static let paymentCreated = "paymentCreated"
        static let paymentPaid = "paid"
        static let paymentError = "error"
        static let configuredPaymentFailed = "configuredPaymentFailed"
        static let ambiguousAlias = "ambiguousAlias"
        static let methodCallError = "methodCallError"
    }

    // MARK: - Properties

    let type: String
    let message: String?
    let paymentUrl: String?
    let transactionId: String?
    let aliases: [T.AmbiguousAlias]?

    // MARK: - Results

    static func ambiguousAlias(aliases: [T.AmbiguousAlias], transactionId: String) -> ScreenlessResult {
        return .init(type: Constant.ambiguousAlias, message: nil, paymentUrl: nil, transactionId: transactionId, aliases: aliases)
    }

    static func paymentCreated(continueUrl: URL?, transactionId: String) -> ScreenlessResult {
        if let continueUrl {
            return .init(type: Constant.paymentCreated, message: nil, paymentUrl: continueUrl.absoluteString, transactionId: transactionId, aliases: nil)
        }
        return .init(type: Constant.paymentPaid, message: nil, paymentUrl: nil, transactionId: transactionId, aliases: nil)
    }

    static func paymentFailure(error: Error) -> ScreenlessResult {
        return .errorResult(type: Constant.paymentError, error: error)
    }

    static func methodCallError() -> ScreenlessResult {
        return .init(type: Constant.methodCallError, message: "Unable to parse sent data.", paymentUrl: nil, transactionId: nil, aliases: nil)
    }

    // MARK: - Private

    private static func errorResult(type: String, error: Error) -> ScreenlessResult {
        .init(type: type, message: "\(error)", paymentUrl: nil, transactionId: nil, aliases: nil)
    }
}

// MARK: - Extensions

extension ScreenlessResult {

    func toJson() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            debugPrint("Error converting ConfigurationResult to JSON: \(error)")
        }
        return ""
    }
}
