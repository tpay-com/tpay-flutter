import Flutter
import Tpay

final class PaymentPresentation: PaymentDelegate {

    // MARK: - Properties

    var paymentResult: ((String) -> Void)?
    var paymentIntermediateResult: ((String) -> Void)?

    private var paymentSheet: Payment.Sheet?
    private var currnetViewController: FlutterViewController?

    // MARK: - API

    func presentPayment(for transaction: Transaction) throws {
        currnetViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController
        paymentSheet = Payment.Sheet(transaction: transaction, delegate: self)

        guard let currnetViewController = currnetViewController else {
            return
        }

        try paymentSheet?.present(from: currnetViewController)
    }

    // MARK: - PaymentDelegate

    func onPaymentCreated(transactionId: String) {
        paymentIntermediateResult?(ConfigurationResult.paymentCreated(transactionId: transactionId).toJson())
    }

    func onPaymentCompleted(transactionId: String) {
        paymentResult?(ConfigurationResult.paymentCompleted(transactionId: transactionId).toJson())
        complete()
    }

    func onPaymentCancelled(transactionId: String) {
        paymentResult?(ConfigurationResult.paymentCancelled(transactionId: transactionId).toJson())
        complete()
    }

    func onErrorOccured(error: ModuleError) {
        paymentResult?(ConfigurationResult.payment(error: error).toJson())
        complete()
    }

    // MARK: - Private

    private func complete() {
        paymentSheet?.dismiss()
        paymentSheet = nil
    }
}
