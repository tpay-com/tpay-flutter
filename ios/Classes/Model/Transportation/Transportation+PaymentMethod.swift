import Tpay

extension Transportation {

    enum PaymentMethod: String {

        // MARK: - Cases

        case card
        case blik
        case transfer
        case applePay
        case googlePay

        // MARK: - Properties

        var tpayPaymentMethod: Tpay.PaymentMethod {
            switch self {
            case .card:
                return .card
            case .blik:
                return .blik
            case .transfer:
                return .pbl
            case .applePay:
                return .digitalWallet(.applePay)
            case .googlePay:
                return .digitalWallet(.googlePay)
            }
        }
    }
}
