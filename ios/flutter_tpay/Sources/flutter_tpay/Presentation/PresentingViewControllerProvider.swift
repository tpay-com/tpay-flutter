import Flutter
import UIKit

final class PresentingViewControllerProvider {

    // MARK: - Properties

    private weak var registrar: FlutterPluginRegistrar?

    // MARK: - Initializers

    init(registrar: FlutterPluginRegistrar?) {
        self.registrar = registrar
    }

    // MARK: - API

    /// Returns the view controller displaying Flutter content.
    /// With the UIScene lifecycle `UIApplication.shared.delegate?.window` is nil, so the registrar is asked first
    /// and the application delegate window and the key window of the connected scenes are used as fallbacks.
    func viewController() -> UIViewController? {
        if let viewController = registrarViewController() {
            return viewController
        }
        if let viewController = UIApplication.shared.delegate?.window??.rootViewController {
            return viewController
        }
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }

    // MARK: - Private

    /// `FlutterPluginRegistrar.viewController` is available since Flutter 3.38, so it is read dynamically
    /// to keep the plugin compiling with older Flutter versions.
    private func registrarViewController() -> UIViewController? {
        let key = "viewController"
        guard let registrar = registrar as? NSObject,
              registrar.responds(to: NSSelectorFromString(key)) else {
            return nil
        }
        return registrar.value(forKey: key) as? UIViewController
    }
}
