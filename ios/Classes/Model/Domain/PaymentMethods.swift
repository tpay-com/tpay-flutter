import Tpay

struct PaymentMethods {

    // MARK: - Properties

    let availableTransferMethods: [PaymentData.Bank]
    let availableDigitalWallets: [DigitalWallet]
    let availablePaymentMethods: [PaymentMethod]
}
