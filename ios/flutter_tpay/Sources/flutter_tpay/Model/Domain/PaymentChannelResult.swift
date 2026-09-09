import Foundation

struct PaymentChannelResult: Encodable {

    // MARK: - Constants

    private enum Constant {
        static let configurationSuccess = "success"
        static let configurationError = "success"
    }

    // MARK: - Properties

    let type: String
    let message: String?
    let channels: [T.PaymentChannel]?

    // MARK: - Results

    static func configurationValid(channels: [T.PaymentChannel]) -> PaymentChannelResult {
        return .init(type: Constant.configurationSuccess, message: nil, channels: channels)
    }

    static func configurationError(error: Error) -> PaymentChannelResult {
        return .init(type: Constant.configurationError, message: "\(error)", channels: nil)
    }
}

// MARK: - Extensions

extension PaymentChannelResult {

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
