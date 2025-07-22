import Tpay

struct BankPayment: Transaction {

    // MARK: - Properties

    let amount: Double
    let description: String
    let payerContext: PayerContext?
    let paymentChannel: Headless.Models.PaymentChannel
    let callbacks: CallbacksConfiguration
    let hiddenDescription: String?
}
