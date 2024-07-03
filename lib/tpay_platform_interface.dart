import 'package:flutter_tpay/model/result/payment_channels_result.dart';
import 'package:flutter_tpay/model/screenless/pay_po_payment.dart';
import 'package:flutter_tpay/model/screenless/raty_pekao_payment.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_tpay/model/screenless/ambiguous_blik_payment.dart';
import 'package:flutter_tpay/model/screenless/apple_pay_payment.dart';
import '/model/tpay_configuration.dart';
import 'model/result/google_pay_configure_result.dart';
import 'model/result/google_pay_open_result.dart';
import 'model/result/result.dart';
import 'model/result/screenless_result.dart';
import 'model/screenless/blik_payment.dart';
import 'model/screenless/credit_card_payment.dart';
import 'model/screenless/google_pay_payment.dart';
import 'model/screenless/google_pay_utils_configuration.dart';
import 'model/screenless/transfer_payment.dart';
import 'model/tokenization/tokenization.dart';
import 'model/transaction/single_transaction.dart';
import 'model/transaction/token_payment.dart';
import 'tpay_method_channel.dart';

abstract class TpayPlatform extends PlatformInterface {
  TpayPlatform() : super(token: _token);

  static final Object _token = Object();
  static TpayPlatform _instance = MethodChannelTpay();
  static TpayPlatform get instance => _instance;
  static set instance(TpayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Method used to configure Tpay UI Module
  /// Returns [ConfigurationSuccess] when successful.
  Future<Result> configure(TpayConfiguration configuration);

  /// Method used to start standard payment with Tpay UI Module
  Future<Result> startPayment(SingleTransaction transaction);

  /// Method used to tokenize credit card with Tpay UI Module
  Future<Result> tokenizeCard(Tokenization tokenization);

  /// Method used to fetch payment channels from Tpay
  Future<PaymentChannelsResult> getAvailablePaymentChannels();

  /// Method used to start credit card token payment with Tpay UI Module
  Future<Result> startCardTokenPayment(TokenPayment tokenPayment);

  /// Method used to start screenless BLIK payment
  Future<ScreenlessResult> screenlessBLIKPayment(BLIKPayment blikPayment);

  /// Method used to continue BLIK one click payment if ambiguous aliases were returned
  Future<ScreenlessResult> screenlessAmbiguousBLIKPayment(AmbiguousBLIKPayment ambiguousBLIKPayment);

  /// Method used to start screenless transfer payment
  Future<ScreenlessResult> screenlessTransferPayment(TransferPayment transferPayment);

  /// Method used to start screenless Raty Pekao payment
  Future<ScreenlessResult> screenlessRatyPekaoPayment(RatyPekaoPayment ratyPekaoPayment);

  /// Method used to start screenless PayPo payment
  Future<ScreenlessResult> screenlessPayPoPayment(PayPoPayment payPoPayment);

  /// Method used to start screenless credit card payment
  Future<ScreenlessResult> screenlessCreditCardPayment(CreditCardPayment creditCardPayment);

  /// Method used to start screenless Apple Pay payment
  Future<ScreenlessResult> screenlessApplePayPayment(ApplePayPayment applePayPayment);

  /// Method used to start screenless Google Pay payment
  Future<ScreenlessResult> screenlessGooglePayPayment(GooglePayPayment googlePayPayment);

  /// Method used to configure Google Pay utils
  Future<GooglePayConfigureResult> configureGooglePayUtils(GooglePayUtilsConfiguration googlePayUtilsConfiguration);

  /// Method used to open Google Pay
  Future<GooglePayOpenResult> openGooglePay();

  /// Method used to check if Google Pay is available
  Future<bool> isGooglePayAvailable();
}
