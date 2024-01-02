import Tpay

struct BankPayment {

    // MARK: - Properties

    let bankData: PaymentData.Bank
    let amount: Double
    let payer: Payer
}
