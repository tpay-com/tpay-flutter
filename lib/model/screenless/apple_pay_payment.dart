import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';
import '../payer/payer.dart';
import 'callbacks.dart';

part 'apple_pay_payment.g.dart';

/// Class responsible for storing information about Apple Pay payment.
/// You have to provide [applePayToken] received from Apple Pay.
@JsonSerializable(explicitToJson: true)
class ApplePayPayment extends ScreenlessPayment {
  final String applePayToken;

  ApplePayPayment({
    required super.paymentDetails,
    required super.payer,
    required this.applePayToken,
    super.callbacks
  });

  factory ApplePayPayment.fromJson(Map<String, dynamic> json) => _$ApplePayPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$ApplePayPaymentToJson(this);
}