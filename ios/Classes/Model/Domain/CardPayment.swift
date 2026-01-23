import Tpay

struct CardPayment: Transaction {

    // MARK: - Properties

    let amount: Double
    let description: String
    let hiddenDescription: String?
    let payerContext: PayerContext?
    let paymentChannel: Headless.Models.PaymentChannel
    let card: Headless.Models.Card?
    let cardToken: Headless.Models.CardToken?
    let callbacks: CallbacksConfiguration
}
