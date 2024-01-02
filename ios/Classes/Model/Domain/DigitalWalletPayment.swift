import Tpay

struct DigitalWalletPayment {

    // MARK: - Properties

    let walletData: PaymentData.DigitalWallet
    let amount: Double
    let payer: Payer
}
