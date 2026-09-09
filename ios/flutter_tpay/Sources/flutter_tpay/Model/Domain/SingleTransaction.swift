import Tpay

struct SingleTransaction: Transaction {
    let singleTransaction: Tpay.SingleTransaction
    let callbacks: CallbacksConfiguration

    var amount: Double { singleTransaction.amount }
    var description: String { singleTransaction.description }
    var hiddenDescription: String? { singleTransaction.hiddenDescription }
    var payerContext: PayerContext? { singleTransaction.payerContext }
}