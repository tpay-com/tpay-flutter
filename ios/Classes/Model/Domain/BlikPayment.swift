import Tpay

struct BlikPayment: Transaction {

    // MARK: - Properties

    let amount: Double
    let description: String
    let hiddenDescription: String?
    let payerContext: PayerContext?
    let token: String?
    let alias: String?
    let paymentChannel: Headless.Models.PaymentChannel
    let callbacks: CallbacksConfiguration
    let notification: Tpay.Notification?
}
