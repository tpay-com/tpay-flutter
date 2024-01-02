import Tpay

final class PaymentMethodsConfiguration {

    // MARK: - API

    static func configuration(for paymentMethods: PaymentMethods) -> String {
        let paymentMethodsInfo = makePaymentMethodsInfo(fro: paymentMethods)
        return toJson(form: paymentMethodsInfo)
    }

    // MARK: - Private

    private static func makePaymentMethodsInfo(fro paymentMethods: PaymentMethods) -> T.PaymentMethodsInfo {
        let isBLIKPaymentAvailable = paymentMethods.availablePaymentMethods.contains(where: { $0 == .blik })
        let isCreditCardPaymentAvailable = paymentMethods.availablePaymentMethods.contains(where: { $0 == .card })

        let availableTransferMethods = makeTransportationTransferMethods(from: paymentMethods.availableTransferMethods)
        let availableDigitalWallets = makeTransportationDigitalWallets(form: paymentMethods.availableDigitalWallets)

        let paymentMethodsInfo = T.PaymentMethodsInfo(isBLIKPaymentAvailable: isBLIKPaymentAvailable,
                                                      isCreditCardPaymentAvailable: isCreditCardPaymentAvailable,
                                                      availableTransferMethods: availableTransferMethods,
                                                      availableDigitalWallets: availableDigitalWallets)
        return paymentMethodsInfo
    }

    private static func makeTransportationDigitalWallets(form digitalWallets: [DigitalWallet]) -> [String] {
        var availableDigitalWallets: [String] = []

        if digitalWallets.contains(where: { $0 == .applePay }) {
            availableDigitalWallets.append(T.PaymentMethod.applePay.rawValue)
        }

        if digitalWallets.contains(where: { $0 == .googlePay }) {
            availableDigitalWallets.append(T.PaymentMethod.googlePay.rawValue)
        }

        return availableDigitalWallets
    }

    private static func makeTransportationTransferMethods(from _: [PaymentData.Bank]) -> [T.BankPayment.Bank] {
        #warning("TODO: - Update Tpay ios repo")
//        return tranferMethods.map { T.BankPayment.Bank(id: $0.id, name: $0.name, imageUrl: $0.imageUrl) }
        return []
    }

    private static func toJson(form info: T.PaymentMethodsInfo) -> String {
        do {
            let jsonData = try JSONEncoder().encode(info)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            debugPrint("Error converting ConfigurationResult to JSON: \(error)")
        }
        return ""
    }
}
