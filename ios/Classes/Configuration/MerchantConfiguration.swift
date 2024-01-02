import Security
import Tpay

final class MerchantConfiguration {

    // MARK: - Properties

    private let configuration: T.MerchantConfiguration

    // MARK: - Initializers

    init?(configuration: String) {
        guard let configurationData = configuration.data(using: .utf8),
              let configuration = try? JSONDecoder().decode(T.MerchantConfiguration.self, from: configurationData) else { return nil }
        self.configuration = configuration
    }

    // MARK: - API

    func merchant() -> Merchant? {
        let merchant = configuration.merchant
        guard let environment = makeEnvironment(from: merchant.environment) else { return nil }

        let cardApi = makeCardApi(from: merchant.certificatePinningConfiguration)
        let blikConfiguration = makeBlikConfiguration(from: merchant.blikAliasToRegister)
        let walletConfiguration = makeWalletConfiguration(from: merchant.walletConfiguration?.applePay)

        return .init(authorization: .init(clientId: merchant.authorization.clientId, clientSecret: merchant.authorization.clientSecret),
                     cardsConfiguration: cardApi,
                     environment: environment,
                     blikConfiguration: blikConfiguration,
                     walletConfiguration: walletConfiguration)
    }

    func paymentMethods() -> [PaymentMethod]? {
        guard let configurationPaymentMethods = configuration.paymentMethods else { return nil }

        let methods = configurationPaymentMethods.methods.compactMap { T.PaymentMethod(rawValue: $0)?.tpayPaymentMethod }
        let wallets = (configurationPaymentMethods.wallets ?? []).compactMap { T.PaymentMethod(rawValue: $0)?.tpayPaymentMethod }
        let paymentMethods = methods + wallets

        return paymentMethods.isEmpty ? nil : paymentMethods
    }

    func preferredLanguage() -> Language? {
        guard let preferredLanguage = configuration.languages?.preferredLanguage else { return nil }
        return .init(rawValue: preferredLanguage)
    }

    func supportedLanguage() -> [Language] {
        guard let supportedLanguages = configuration.languages?.supportedLanguages else { return [] }
        return supportedLanguages.compactMap { Language(rawValue: $0) }
    }

    func detailsProvider() -> DefaultMerchantDetailsProvider {
        let details = configuration.merchantDetails

        var merchantDisplayName: [Language: String] = [:]
        if let displayNames = details.merchantDisplayName {
            displayNames.forEach { detail in
                if let language = Language(rawValue: detail.language) {
                    merchantDisplayName[language] = detail.value
                }
            }
        }

        var merchantHeadquarters: [Language: String] = [:]
        if let headquaters = details.merchantHeadquarters {
            headquaters.forEach { detail in
                if let language = Language(rawValue: detail.language) {
                    merchantHeadquarters[language] = detail.value
                }
            }
        }

        var regulationsLink: [Language: URL] = [:]
        if let links = details.regulations {
            links.forEach { detail in
                if let language = Language(rawValue: detail.language), let url = URL(string: detail.value) {
                    regulationsLink[language] = url
                }
            }
        }

        return .init(merchantDisplayName: merchantDisplayName, merchantHeadquarters: merchantHeadquarters, regulationsLink: regulationsLink)
    }

    func sslCertificatesProvider() -> DefaultSSLCertificatesProvider? {
        guard let publicKeyHash = configuration.merchant.certificatePinningConfiguration?.publicKeyHash else { return nil }
        return .init(apiConfiguration: .init(publicKeyHashes: [publicKeyHash]))
    }

    // MARK: - Private

    private func makeCardApi(from certificatePinningConfiguration: T.Merchant.CertificatePinning?) -> Merchant.CardsAPI? {
        guard let publicKeyHash = certificatePinningConfiguration?.publicKeyHash else { return nil }
        return try? .init(publicKey: publicKeyHash)
    }

    private func makeEnvironment(from environment: String) -> Merchant.Environment? {
        guard let environment = T.Environment(rawValue: environment) else { return nil }
        return environment.tpayEnvironment
    }

    private func makeBlikConfiguration(from blikAliasToRegister: String?) -> Merchant.BlikConfiguration? {
        guard let blikAliasToRegister = blikAliasToRegister else { return nil }

        return .init(aliasToBeRegistered: .init(value: .uid(blikAliasToRegister)))
    }

    private func makeWalletConfiguration(from applePayConfiguration: T.Merchant.WalletConfiguration.ApplePay?) -> Merchant.WalletConfiguration? {
        guard let applePayConfiguration = applePayConfiguration,
              let countryCode = Merchant.WalletConfiguration.ApplePayConfiguration.CountryCode(rawValue: applePayConfiguration.countryCode)
        else { return nil }

        return .init(applePayConfiguration: .init(merchantIdentifier: applePayConfiguration.merchantIdentifier,
                                                  countryCode: countryCode))
    }
}
