import Tpay

final class PaymentMethodsConfiguration {

    // MARK: - Constants

    enum Constants {
        static let amount = "amount"
        static let min = "min"
        static let max = "max"
    }

    // MARK: - API

    static func configuration(for paymentChannels: [Headless.Models.PaymentChannel]) -> [T.PaymentChannel] {
        makePaymentChannelsInfo(from: paymentChannels)
    }

    // MARK: - Private

    private static func makePaymentChannelsInfo(from paymentChannels: [Headless.Models.PaymentChannel]) -> [T.PaymentChannel] {
        paymentChannels.map { makeTransportationPaymentChanel(from: $0) }
    }

    private static func makeTransportationPaymentChanel(from paymentChanel: Headless.Models.PaymentChannel) -> T.PaymentChannel {
        T.PaymentChannel(id: paymentChanel.id,
                         name: paymentChanel.fullName,
                         imageUrl: paymentChanel.imageUrl?.absoluteString,
                         constraints: makeDomainConstains(from: paymentChanel.constraints ?? []))
    }

    private static func makeDomainConstains(from constains: [Headless.Models.PaymentChannel.Constraint]) -> [T.PaymentChannel.Constraint] {
        let amountConstraints = constains.filter { $0.field == Constants.amount }
        let min = amountConstraints.filter { $0.type == Constants.min }.map { Double($0.value) }.first ?? nil
        let max = amountConstraints.filter { $0.type == Constants.max }.map { Double($0.value) }.first ?? nil
        if min == nil, max == nil {
            return []
        }
        return [.init(type: Constants.amount.uppercased(), minimum: min, maximum: max)]
    }
}
