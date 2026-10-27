import Flutter
import Tpay

final class AddCardPresentation: AddCardDelegate {

    // MARK: - Properties

    var addCardResult: ((String) -> Void)?

    private var addCardSheet: AddCard.Sheet?
    private let viewControllerProvider: PresentingViewControllerProvider

    // MARK: - Initializers

    init(viewControllerProvider: PresentingViewControllerProvider) {
        self.viewControllerProvider = viewControllerProvider
    }

    // MARK: - API

    func presentAddCard(for payer: Payer) throws {
        addCardSheet = AddCard.Sheet(payer: payer, delegate: self)

        guard let viewController = viewControllerProvider.viewController() else {
            throw NSError(
                domain: "com.tpay.flutter",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Unable to get root view controller for add card presentation"]
            )
        }

        try addCardSheet?.present(from: viewController)
    }

    // MARK: - AddCardDelegate

    func onTokenizationCompleted() {
        addCardResult?(ConfigurationResult.tokenizationCompleted().toJson())
        complete()
    }

    func onTokenizationCancelled() {
        addCardResult?(ConfigurationResult.paymentClosed().toJson())
        complete()
    }

    // MARK: - Private

    private func complete() {
        addCardSheet?.dismiss()
        addCardSheet = nil
    }
}
