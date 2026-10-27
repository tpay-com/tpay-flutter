import Flutter
import Tpay

final class PaymentPresentation: PaymentDelegate {

    // MARK: - Properties

    var paymentResult: ((String) -> Void)?
    var paymentIntermediateResult: ((String) -> Void)?

    private var paymentSheet: Payment.Sheet?
    private let viewControllerProvider: PresentingViewControllerProvider

    // MARK: - Initializers

    init(viewControllerProvider: PresentingViewControllerProvider) {
        self.viewControllerProvider = viewControllerProvider
    }

    // MARK: - API

    func presentPayment(for transaction: Transaction) throws {
        paymentSheet = Payment.Sheet(transaction: transaction, delegate: self)

        guard let viewController = viewControllerProvider.viewController() else {
            throw NSError(
                domain: "com.tpay.flutter",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Unable to get root view controller for payment presentation"]
            )
        }

        try paymentSheet?.present(from: viewController)
    }

    // MARK: - PaymentDelegate

    func onPaymentCreated(transactionId: String) {
        paymentIntermediateResult?(ConfigurationResult.paymentCreated(transactionId: transactionId).toJson())
    }

    func onPaymentCompleted(transactionId: String) {
        paymentResult?(ConfigurationResult.paymentCompleted(transactionId: transactionId).toJson())
        complete()
    }
    
    func onPaymentClosed() {
        paymentResult?(ConfigurationResult.paymentClosed().toJson())
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
