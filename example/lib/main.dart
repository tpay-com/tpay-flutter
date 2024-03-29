import 'package:flutter/material.dart';

import 'package:flutter_tpay/model/apple_pay_configuration.dart';
import 'package:flutter_tpay/model/certificate_pinning_configuration.dart';
import 'package:flutter_tpay/model/google_pay_configuration.dart';
import 'package:flutter_tpay/model/language/language.dart';
import 'package:flutter_tpay/model/language/languages.dart';
import 'package:flutter_tpay/model/language/localized_string.dart';
import 'package:flutter_tpay/model/merchant/merchant.dart';
import 'package:flutter_tpay/model/merchant/merchant_authorization.dart';
import 'package:flutter_tpay/model/merchant/merchant_details.dart';
import 'package:flutter_tpay/model/payer/payer.dart';
import 'package:flutter_tpay/model/payer/payer_context.dart';
import 'package:flutter_tpay/model/paymentChannel/payment_constraint.dart';
import 'package:flutter_tpay/model/paymentMethod/automatic_payment_methods.dart';
import 'package:flutter_tpay/model/paymentMethod/blik_alias.dart';
import 'package:flutter_tpay/model/paymentMethod/credit_card_brand.dart';
import 'package:flutter_tpay/model/paymentMethod/digital_wallet.dart';
import 'package:flutter_tpay/model/paymentMethod/installment_payment.dart';
import 'package:flutter_tpay/model/paymentMethod/payment_method.dart';
import 'package:flutter_tpay/model/paymentMethod/payment_methods.dart';
import 'package:flutter_tpay/model/paymentMethod/tokenized_card.dart';
import 'package:flutter_tpay/model/result/google_pay_configure_result.dart';
import 'package:flutter_tpay/model/result/google_pay_open_result.dart';
import 'package:flutter_tpay/model/result/payment_channels_result.dart';
import 'package:flutter_tpay/model/result/result.dart';
import 'package:flutter_tpay/model/result/screenless_result.dart';
import 'package:flutter_tpay/model/screenless/ambiguous_alias.dart';
import 'package:flutter_tpay/model/screenless/ambiguous_blik_payment.dart';
import 'package:flutter_tpay/model/screenless/apple_pay_payment.dart';
import 'package:flutter_tpay/model/screenless/blik_payment.dart';
import 'package:flutter_tpay/model/screenless/credit_card.dart';
import 'package:flutter_tpay/model/screenless/credit_card_config.dart';
import 'package:flutter_tpay/model/screenless/credit_card_payment.dart';
import 'package:flutter_tpay/model/screenless/expiration_date.dart';
import 'package:flutter_tpay/model/screenless/google_pay_environment.dart';
import 'package:flutter_tpay/model/screenless/google_pay_payment.dart';
import 'package:flutter_tpay/model/screenless/google_pay_utils_configuration.dart';
import 'package:flutter_tpay/model/screenless/raty_pekao_payment.dart';
import 'package:flutter_tpay/model/screenless/transfer_payment.dart';
import 'package:flutter_tpay/model/screenless/callbacks.dart';
import 'package:flutter_tpay/model/screenless/notifications.dart';
import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/redirects.dart';
import 'package:flutter_tpay/model/tokenization/tokenization.dart';
import 'package:flutter_tpay/model/tpay_configuration.dart';
import 'package:flutter_tpay/model/tpay_environment.dart';
import 'package:flutter_tpay/model/transaction/single_transaction.dart';
import 'package:flutter_tpay/model/transaction/token_payment.dart';
import 'package:flutter_tpay/model/wallet_configuration.dart';
import 'package:flutter_tpay/tpay_platform_interface.dart';
import 'package:tpay_example/tpay_item_list.dart';

void main() {
  runApp(TpayExample());
}

class TpayExample extends StatelessWidget {
  TpayExample({super.key});

  final TpayPlatform tpayPlatform = TpayPlatform.instance;
  late final Map<String, Function> actions = {
    "Standard payment": openMainPaymentModule,
    "Tokenization": openTokenization,
    "Token payment": openTokenPayment,
    "Get payment channels": getPaymentChannels,
    "BLIK screenless": screenlessBLIKPayment,
    "Transfer screenless": screenlessTransferPayment,
    "Raty Pekao screenless": screenlessRatyPekaoPayment,
    "Credit card screenless": screenlessCreditCardPayment,
    "Google Pay screenless": screenlessGooglePayPayment,
    "Configure Google Pay": configureGooglePayUtils,
    "Open Google Pay": openGooglePay
  };

  late final MerchantAuthorization authorization = MerchantAuthorization(
    clientId: "YOUR_CLIENT_ID",
    clientSecret: "YOUR_CLIENT_SECRET"
  );

  late final CertificatePinningConfiguration pinningConfiguration =
      CertificatePinningConfiguration(publicKeyHash: "PUBLIC_KEY_HASH");

  late final Payer payer = Payer(name: "John Doe", email: "example@example.com", phone: null, address: null);

  late final PaymentDetails paymentDetails = PaymentDetails(
      amount: 39.99,
      description: "transaction description",
      hiddenDescription: "hidden description",
      language: Language.pl);

  late final Callbacks callbacks = Callbacks(
      redirects: Redirects(
        successUrl: "https://yourstore.com/success",
        errorUrl: "https://yourstore.com/error",
      ),
      notifications: Notifications(url: "https://yourstore.com/notifications", email: "payments@yourstore.com")
  );

  late final WalletConfiguration walletConfiguration = WalletConfiguration(
    googlePay: GooglePayConfiguration(merchantId: "YOUR_MERCHANT_ID"),
    applePay: ApplePayConfiguration(merchantIdentifier: "YOUR_MERCHANT_IDENTIFIER", countryCode: "PL")
  );

  late final Merchant merchant = Merchant(
      authorization: authorization,
      environment: TpayEnvironment.sandbox,
      certificatePinningConfiguration: pinningConfiguration,
      blikAliasToRegister: "",
      walletConfiguration: walletConfiguration);

  Future<Result> configure() {
    final configuration = TpayConfiguration(
      merchant: merchant,
      merchantDetails: MerchantDetails(
        merchantDisplayName: [
          LocalizedString(language: Language.pl, value: "polish name"),
          LocalizedString(language: Language.en, value: "english name")
        ],
        merchantHeadquarters: [
          LocalizedString(language: Language.pl, value: "polish city name"),
          LocalizedString(language: Language.en, value: "english city name")
        ],
        regulations: [
          LocalizedString(language: Language.pl, value: "polish regulation url"),
          LocalizedString(language: Language.en, value: "english regulation url")
        ],
      ),
      languages: Languages(preferredLanguage: Language.pl, supportedLanguages: [Language.pl, Language.en]),
      paymentMethods: PaymentMethods(
          methods: [PaymentMethod.card, PaymentMethod.blik, PaymentMethod.transfer],
          wallets: [DigitalWallet.applePay, DigitalWallet.googlePay],
          installmentPayments: [InstallmentPayment.ratyPekao]),
    );

    return tpayPlatform.configure(configuration);
  }

  void openMainPaymentModule() async {
    handleResult(await configure());

    final transaction = SingleTransaction(
        amount: 100.0,
        description: "transaction description",
        payerContext: PayerContext(
            payer: payer,
            automaticPaymentMethods: AutomaticPaymentMethods(tokenizedCards: [
              TokenizedCard(token: "card token", cardTail: "1234", brand: CreditCardBrand.mastercard),
              TokenizedCard(token: "card token", cardTail: "4321", brand: CreditCardBrand.visa)
            ], blikAlias: BlikAlias(isRegistered: true, value: "alias value", label: "label"))));

    handleResult(await tpayPlatform.startPayment(transaction));
  }

  void openTokenization() async {
    handleResult(await configure());
    handleResult(await tpayPlatform
        .tokenizeCard(Tokenization(payer: payer, notificationUrl: "https://yourstore.com/notifications")));
  }

  void openTokenPayment() async {
    handleResult(await configure());

    final tokenPayment = TokenPayment(
      amount: 0.1,
      description: "transaction description",
      cardToken: "card token",
      payer: payer,
    );

    handleResult(await tpayPlatform.startCardTokenPayment(tokenPayment));
  }

  void screenlessBLIKPayment() async {
    handleResult(await configure());

    final payment = BLIKPayment(
        code: "123456",
        alias: BlikAlias(isRegistered: true, value: "alias value", label: "label"),
        paymentDetails: paymentDetails,
        payer: payer,
        callbacks: callbacks);

    handleScreenlessResult(await tpayPlatform.screenlessBLIKPayment(payment));
  }

  void screenlessAmbiguousBLIKPayment() async {
    handleResult(await configure());

    final payment = AmbiguousBLIKPayment(
        transactionId: "transaction id",
        blikAlias: BlikAlias(isRegistered: true, value: "alias value", label: "alias label"),
        ambiguousAlias: AmbiguousAlias(name: "bank name", code: "alias code"));

    handleScreenlessResult(await tpayPlatform.screenlessAmbiguousBLIKPayment(payment));
  }

  void screenlessTransferPayment() async {
    handleResult(await configure());
    final payment = TransferPayment(
        channelId: 4, bankName: "bank name", paymentDetails: paymentDetails, payer: payer, callbacks: callbacks);

    handleScreenlessResult(await tpayPlatform.screenlessTransferPayment(payment));
  }

  void screenlessRatyPekaoPayment() async {
    handleResult(await configure());
    final payment = RatyPekaoPayment(paymentDetails: paymentDetails, payer: payer, callbacks: callbacks, channelId: 81);
    handleScreenlessResult(await tpayPlatform.screenlessRatyPekaoPayment(payment));
  }

  void getPaymentChannels() async {
    handleResult(await configure());
    handlePaymentChannelsResult(await tpayPlatform.getAvailablePaymentChannels());
  }

  void screenlessCreditCardPayment() async {
    handleResult(await configure());

    final payment = CreditCardPayment(
        creditCard: CreditCard(
            cardNumber: "111111111111",
            expiryDate: ExpirationDate(month: "12", year: "24"),
            cvv: "123",
            config: CreditCardConfig(shouldSave: false, domain: "yourstore.com")),
        creditCardToken: "card token",
        paymentDetails: paymentDetails,
        payer: payer,
        callbacks: callbacks);

    handleScreenlessResult(await tpayPlatform.screenlessCreditCardPayment(payment));
  }

  void screenlessGooglePayPayment() async {
    handleResult(await configure());
    final payment =
        GooglePayPayment(token: "google pay token", paymentDetails: paymentDetails, payer: payer, callbacks: callbacks);

    handleScreenlessResult(await tpayPlatform.screenlessGooglePayPayment(payment));
  }

  void screenlessApplePayPayment() async {
    final payment = ApplePayPayment(paymentDetails: paymentDetails, payer: payer, applePayToken: "apple pay token");

    await tpayPlatform.screenlessApplePayPayment(payment);
  }

  void configureGooglePayUtils() async {
    final result = await tpayPlatform.configureGooglePayUtils(GooglePayUtilsConfiguration(
        price: 9.99,
        merchantName: "YOUR_STORE_NAME",
        merchantId: "MERCHANT_ID",
        environment: GooglePayEnvironment.production));

    handleGooglePayUtilsConfigurationResult(result);
  }

  void openGooglePay() async {
    final result = await tpayPlatform.openGooglePay();
    handleOpenGooglePayResult(result);
  }

  void handleOpenGooglePayResult(GooglePayOpenResult result) {
    if (result is GooglePayOpenSuccess) {
      debugPrint("Google Pay open success");
      debugPrint("token: ${result.token}");
      debugPrint("description: ${result.description}");
      debugPrint("cardNetwork: ${result.cardNetwork}");
      debugPrint("cardTail: ${result.cardTail}");
    }
    if (result is GooglePayOpenCancelled) {
      debugPrint("Google Pay cancelled by user");
    }
    if (result is GooglePayOpenUnknownError) {
      debugPrint("Google Pay unknown error");
    }
    if (result is GooglePayOpenNotConfigured) {
      debugPrint("Google Pay not configured");
    }
  }

  void handleGooglePayUtilsConfigurationResult(GooglePayConfigureResult result) {
    if (result is GooglePayConfigureSuccess) {
      debugPrint("Google Pay utils configuration success");
    }

    if (result is GooglePayConfigureError) {
      debugPrint("Google Pay utils configuration error: ${result.message}");
    }
  }

  void handlePaymentChannelsResult(PaymentChannelsResult result) {
    if (result is PaymentChannelsSuccess) {
      debugPrint("Payment channels success");
      debugPrint("Available payment channels:");
      for (var channel in result.channels) {
        debugPrint("id: ${channel.id}, name: ${channel.name}, imageUrl: ${channel.imageUrl}");
        for (var constraint in channel.constraints) {
          if (constraint is AmountPaymentConstraint) {
            debugPrint("Amount constraint minimum: ${constraint.minimum}, maximum: ${constraint.maximum}");
          }
        }
      }
    }
    if (result is PaymentChannelsError) {
      debugPrint("Payment channels error: ${result.message}");
    }
  }

  void handleScreenlessResult(ScreenlessResult result) {
    if (result is ScreenlessPaid) {
      debugPrint("Screenless paid: ${result.transactionId}");
    }
    if (result is ScreenlessPaymentCreated) {
      debugPrint("Screenless payment created: ${result.transactionId}, ${result.paymentUrl}");
    }
    if (result is ScreenlessPaymentError) {
      debugPrint("Screenless payment error: ${result.error}");
    }
    if (result is ScreenlessConfiguredPaymentFailed) {
      debugPrint("Screenless configured payment failed: ${result.transactionId}, ${result.error}");
    }
    if (result is ScreenlessBlikAmbiguousAlias) {
      debugPrint("Screenless BLIK ambiguous alias: ${result.transactionId}, ${result.aliases}");
    }
    if (result is ScreenlessValidationError) {
      debugPrint("Screenless validation error: ${result.message}");
    }
    if (result is ScreenlessMethodCallError) {
      debugPrint("Screenless method call error: ${result.message}");
    }
  }

  void handleResult(Result result) {
    if (result is PaymentCompleted) {
      debugPrint("Payment completed: ${result.transactionId}");
    }
    if (result is PaymentCancelled) {
      debugPrint("Payment cancelled: ${result.transactionId}");
    }
    if (result is TokenizationCompleted) {
      debugPrint("Tokenization completed");
    }
    if (result is TokenizationFailure) {
      debugPrint("Tokenization failure");
    }
    if (result is ConfigurationSuccess) {
      debugPrint("Configuration successful");
    }
    if (result is ValidationError) {
      debugPrint("Validation error: ${result.message}");
    }
    if (result is ModuleClosed) {
      debugPrint("Module closed");
    }
    if (result is MethodCallError) {
      debugPrint("Method call error: ${result.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tpay example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TpayItemList(actions: actions),
        ),
      ),
    );
  }
}
