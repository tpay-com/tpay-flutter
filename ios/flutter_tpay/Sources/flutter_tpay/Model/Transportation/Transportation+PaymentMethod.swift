import Tpay

extension Transportation {

    enum PaymentMethod: String, CaseIterable, Encodable {

        // MARK: - Cases

        case card
        case blik
        case transfer
        case applePay
        case ratyPekao
        case payPo

        // MARK: - Properties

        var paymentOrder: Int {
            switch self {
            case .card:
                return 0
            case .blik:
                return 1
            case .ratyPekao:
                return 2
            case .transfer:
                return 3
            case .applePay:
                return 4
            case .payPo:
                return 5
            }
        }

        var tpayPaymentMethod: Tpay.PaymentMethod {
            switch self {
            case .card:
                return .card
            case .blik:
                return .blik
            case .ratyPekao:
                return .installmentPayments(.ratyPekao)
            case .transfer:
                return .pbl
            case .applePay:
                return .digitalWallet(.applePay)
            case .payPo:
                return .payPo
            }
        }
    }
}
