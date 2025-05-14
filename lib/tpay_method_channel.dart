import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_tpay/model/screenless/apple_pay_payment.dart';
import 'package:flutter_tpay/model/screenless/pay_po_payment.dart';
import 'package:flutter_tpay/util/google_pay_util.dart';
import 'package:flutter_tpay/util/payment_channels_util.dart';
import 'package:flutter_tpay/util/result_util.dart';
import 'package:flutter_tpay/util/screenless_result_util.dart';
import 'model/result/google_pay_configure_result.dart';
import 'model/result/google_pay_open_result.dart';
import 'model/result/payment_channels_result.dart';
import 'model/result/result.dart';
import 'model/result/screenless_result.dart';
import 'model/screenless/ambiguous_blik_payment.dart';
import 'model/screenless/blik_payment.dart';
import 'model/screenless/credit_card_payment.dart';
import 'model/screenless/google_pay_payment.dart';
import 'model/screenless/google_pay_utils_configuration.dart';
import 'model/screenless/raty_pekao_payment.dart';
import 'model/screenless/transfer_payment.dart';
import 'model/tokenization/tokenization.dart';
import 'model/tpay_configuration.dart';
import 'model/transaction/single_transaction.dart';
import 'model/transaction/token_payment.dart';
import 'tpay_platform_interface.dart';

const methodChannel = MethodChannel("tpay");
const eventChannel = EventChannel("tpay.event");
const configureMethod = "configure";
const startPaymentMethod = "startPayment";
const tokenizeCardMethod = "tokenizeCard";
const startCardTokenPaymentMethod = "startCardTokenPayment";
const screenlessBLIKPaymentMethod = "screenlessBLIKPayment";
const screenlessTransferPaymentMethod = "screenlessTransferPayment";
const screenlessRatyPekaoPaymentMethod = "screenlessRatyPekaoPayment";
const screenlessPayPoPaymentMethod = "screenlessPayPoPayment";
const screenlessCreditCardPaymentMethod = "screenlessCreditCardPayment";
const screenlessGooglePayPaymentMethod = "screenlessGooglePayPayment";
const getPaymentChannelsMethod = "getPaymentChannels";
const configureGooglePayUtilsMethod = "configureGooglePayUtils";
const openGooglePayMethod = "openGooglePay";
const isGooglePayAvailableMethod = "isGooglePayAvailable";
const screenlessApplePayMethod = "paymentWithApplePay";
const screenlessAmbiguousBLIKPaymentMethod = "screenlessAmbiguousBLIKPayment";

class MethodChannelTpay extends TpayPlatform {
  @override
  Future<Result> configure(TpayConfiguration configuration) async {
    final result = await methodChannel.invokeMethod(configureMethod, jsonEncode(configuration));

    return mapResult(result);
  }

  @override
  Future<Result> startPayment(
    SingleTransaction transaction, {
    void Function(String? transactionId)? onPaymentCreated,
  }) async {
    final intermediateResultStreamListener = eventChannel.receiveBroadcastStream().listen(
      (result) {
        final mappedResult = mapResult(result);
        if (mappedResult is PaymentCreated) {
          onPaymentCreated?.call(mappedResult.transactionId);
        }
      },
    );
    final result = await methodChannel
        .invokeMethod(startPaymentMethod, jsonEncode(transaction))
        .whenComplete(() => intermediateResultStreamListener.cancel());

    return mapResult(result);
  }

  @override
  Future<Result> tokenizeCard(Tokenization tokenization) async {
    final result = await methodChannel.invokeMethod(tokenizeCardMethod, jsonEncode(tokenization));

    return mapResult(result);
  }

  @override
  Future<Result> startCardTokenPayment(TokenPayment tokenPayment) async {
    final result = await methodChannel.invokeMethod(startCardTokenPaymentMethod, jsonEncode(tokenPayment));

    return mapResult(result);
  }

  @override
  Future<PaymentChannelsResult> getAvailablePaymentChannels() async {
    final result = await methodChannel.invokeMethod(getPaymentChannelsMethod);

    return mapPaymentChannelsResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessBLIKPayment(BLIKPayment blikPayment) async {
    final result = await methodChannel.invokeMethod(screenlessBLIKPaymentMethod, jsonEncode(blikPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessAmbiguousBLIKPayment(AmbiguousBLIKPayment ambiguousBLIKPayment) async {
    final result =
        await methodChannel.invokeMethod(screenlessAmbiguousBLIKPaymentMethod, jsonEncode(ambiguousBLIKPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessTransferPayment(TransferPayment transferPayment) async {
    final result = await methodChannel.invokeMethod(screenlessTransferPaymentMethod, jsonEncode(transferPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessRatyPekaoPayment(RatyPekaoPayment ratyPekaoPayment) async {
    final result = await methodChannel.invokeMethod(screenlessRatyPekaoPaymentMethod, jsonEncode(ratyPekaoPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessPayPoPayment(PayPoPayment payPoPayment) async {
    final result = await methodChannel.invokeMethod(screenlessPayPoPaymentMethod, jsonEncode(payPoPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessCreditCardPayment(CreditCardPayment creditCardPayment) async {
    final result = await methodChannel.invokeMethod(screenlessCreditCardPaymentMethod, jsonEncode(creditCardPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessApplePayPayment(ApplePayPayment applePayPayment) async {
    final result = await methodChannel.invokeMethod(screenlessApplePayMethod, jsonEncode(applePayPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<ScreenlessResult> screenlessGooglePayPayment(GooglePayPayment googlePayPayment) async {
    final result = await methodChannel.invokeMethod(screenlessGooglePayPaymentMethod, jsonEncode(googlePayPayment));

    return mapScreenlessResult(result);
  }

  @override
  Future<GooglePayConfigureResult> configureGooglePayUtils(
      GooglePayUtilsConfiguration googlePayUtilsConfiguration) async {
    final result =
        await methodChannel.invokeMethod(configureGooglePayUtilsMethod, jsonEncode(googlePayUtilsConfiguration));

    return mapGooglePayConfigurationResult(result);
  }

  @override
  Future<GooglePayOpenResult> openGooglePay() async {
    final result = await methodChannel.invokeMethod(openGooglePayMethod);

    return mapGooglePayOpenResult(result);
  }

  @override
  Future<bool> isGooglePayAvailable() async {
    final result = await methodChannel.invokeMethod(isGooglePayAvailableMethod);

    return result as bool;
  }
}
