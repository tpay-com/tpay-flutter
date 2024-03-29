import Foundation

struct ConfigurationResult: Encodable {

    // MARK: - Constants

    private enum Constant {
        static let configurationSuccess = "configurationSuccess"
        static let configurationFailure = "configurationFailure"
        static let paymentCompleted = "paymentCompleted"
        static let paymentCancelled = "paymentCancelled"
        static let paymentError = "paymentError"
        static let tokenPaymentCompleted = "tokenPaymentCompleted"
        static let tokenPaymentCancelled = "tokenPaymentCancelled"
        static let tokenPaymentError = "tokenPaymentError"
        static let tokenizationCompleted = "tokenizationCompleted"
        static let tokenizationCancelled = "tokenizationCancelled"
        static let unknownHandleMethod = "unknownHandleMethod"
    }

    // MARK: - Properties

    let type: String
    let message: String?

    // MARK: - Results

    static func configurationValid() -> ConfigurationResult {
        return .init(type: Constant.configurationSuccess, message: nil)
    }

    static func configurationFailure() -> ConfigurationResult {
        return .init(type: Constant.configurationFailure, message: nil)
    }

    static func configurationFailure(error: Error) -> ConfigurationResult {
        return .errorResult(type: Constant.configurationFailure, error: error)
    }

    static func paymentCompleted(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.configurationFailure, message: transactionId)
    }

    static func paymentCancelled(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.configurationFailure, message: transactionId)
    }

    static func payment(error: Error) -> ConfigurationResult {
        return .errorResult(type: Constant.paymentError, error: error)
    }

    static func tokenPaymentCompleted(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.tokenPaymentCompleted, message: transactionId)
    }

    static func tokenPaymentCancelled(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.tokenPaymentCancelled, message: transactionId)
    }

    static func tokenPayment(error: Error) -> ConfigurationResult {
        return .errorResult(type: Constant.tokenPaymentError, error: error)
    }

    static func tokenizationCompleted() -> ConfigurationResult {
        return .init(type: Constant.tokenizationCompleted, message: nil)
    }

    static func tokenizationCancelled() -> ConfigurationResult {
        return .init(type: Constant.tokenizationCancelled, message: nil)
    }

    static func unknownHandleMethod() -> ConfigurationResult {
        return .init(type: Constant.unknownHandleMethod, message: nil)
    }

    // MARK: - Private

    private static func errorResult(type: String, error: Error) -> ConfigurationResult {
        .init(type: type, message: "\(error)")
    }
}

// MARK: - Extensions

extension ConfigurationResult {

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
