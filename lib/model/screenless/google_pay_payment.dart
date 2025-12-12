import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';
import '../payer/payer.dart';
import 'callbacks.dart';

part 'google_pay_payment.g.dart';

/// Class responsible for storing information about
/// Google Pay payment. You have to provide [token] received from
/// Google Pay.
@JsonSerializable(explicitToJson: true)
class GooglePayPayment extends ScreenlessPayment {
  GooglePayPayment({
    required super.paymentDetails,
    required super.payer,
    required this.token,
    required super.callbacks
  });

  final String token;

  factory GooglePayPayment.fromJson(Map<String, dynamic> json) => _$GooglePayPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$GooglePayPaymentToJson(this);
}