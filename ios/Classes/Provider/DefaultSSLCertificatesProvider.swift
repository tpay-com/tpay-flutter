import Tpay

final class DefaultSSLCertificatesProvider: SSLCertificatesProvider {

    // MARK: - Properties

    var apiConfiguration: CertificatePinningConfiguration

    // MARK: - Initializers

    init(apiConfiguration: CertificatePinningConfiguration) {
        self.apiConfiguration = apiConfiguration
    }
}
