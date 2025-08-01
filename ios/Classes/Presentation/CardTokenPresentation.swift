import Flutter
import Tpay

final class CardTokenPresentation: CardTokenPaymentDelegate {

    // MARK: - Properties

    var cardTokenPaymentResult: ((String) -> Void)?

    private var cardTokenSheet: CardTokenPayment.Sheet?
    private var currnetViewController: FlutterViewController?

    // MARK: - API

    func presentPayment(for transaction: Transaction) throws {
        currnetViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController
        cardTokenSheet = CardTokenPayment.Sheet(transaction: transaction, delegate: self)

        guard let currnetViewController = currnetViewController else {
            return
        }

        try cardTokenSheet?.present(from: currnetViewController)
    }

    // MARK: - CardTokenPaymentDelegate

    func onCardTokenPaymentCompleted(transactionId: TransactionId) {
        cardTokenPaymentResult?(ConfigurationResult.paymentCompleted(transactionId: transactionId).toJson())
        complete()
    }

    func onCardTokenPaymentCancelled(transactionId: TransactionId) {
        cardTokenPaymentResult?(ConfigurationResult.paymentCancelled(transactionId: transactionId).toJson())
        complete()
    }

    func onCardTokenErrorOccured(error: ModuleError) {
        cardTokenPaymentResult?(ConfigurationResult.payment(error: error).toJson())
        complete()
    }

    // MARK: - Private

    private func complete() {
        cardTokenSheet?.dismiss()
        cardTokenSheet = nil
    }
}
