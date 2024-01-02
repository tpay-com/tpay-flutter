import Flutter
import Tpay

final class AddCardPresentation: AddCardDelegate {

    // MARK: - Properties

    var addCardResult: ((String) -> Void)?

    private var addCardSheet: AddCard.Sheet?
    private var currnetViewController: FlutterViewController?

    // MARK: - API

    func presentAddCard(for payer: Payer) throws {
        currnetViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController
        addCardSheet = AddCard.Sheet(payer: payer, delegate: self)

        guard let currnetViewController = currnetViewController else {
            return
        }

        try addCardSheet?.present(from: currnetViewController)
    }

    // MARK: - AddCardDelegate

    func onTokenizationCompleted() {
        addCardResult?(ConfigurationResult.tokenizationCompleted().toJson())
        complete()
    }

    func onTokenizationCancelled() {
        addCardResult?(ConfigurationResult.tokenizationCancelled().toJson())
        complete()
    }

    // MARK: - Private

    private func complete() {
        addCardSheet?.dismiss()
        addCardSheet = nil
    }
}
