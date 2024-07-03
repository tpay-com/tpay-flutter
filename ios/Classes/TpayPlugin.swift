import Flutter
import UIKit

public class TpayPlugin: NSObject, FlutterPlugin {

    // MARK: - Properties

    private let tpay = TpaySDK()

    // MARK: - API

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tpay", binaryMessenger: registrar.messenger())
        let instance = TpayPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        handle(method: call.method, jsonValue: call.arguments) { jsonResponse in result(jsonResponse) }
    }

    // MARK: - Private

    private func handle(method: String, jsonValue: Any?, resolve: @escaping (String) -> Void) {
        guard let method = BridgeMethod(rawValue: method), let json = jsonValue as? String else {
            resolve(ConfigurationResult.unknownHandleMethod().toJson())
            return
        }

        switch method {
        case .configureMerchant:
            resolve(tpay.configure(json))
        case .singleTransactionPayment:
            tpay.singleTransactionPayment(json) { result in resolve(result) }
        case .cardTokenTransaction:
            tpay.cardTokenTransaction(json) { result in resolve(result) }
        case .addCard:
            tpay.addCard(json) { result in resolve(result) }
        case .paymentWithCard:
            tpay.paymentWithCard(json) { result in resolve(result) }
        case .paymentWithBlik:
            tpay.paymentWithBlik(json) { result in resolve(result) }
        case .paymentWithBank:
            tpay.paymentWithBank(json) { result in resolve(result) }
        case .paymentWithApplePay:
            tpay.paymentWithDigitalWallet(json) { result in resolve(result) }
        case .paymentWithPayPo:
            tpay.paymentWithPayPo(json) { result in resolve(result) }
        case .continuePayment:
            tpay.continuePayment(json) { result in resolve(result) }
        case .getPaymentMethods:
            tpay.getPaymentMethods { result in resolve(result) }
        }
    }
}
