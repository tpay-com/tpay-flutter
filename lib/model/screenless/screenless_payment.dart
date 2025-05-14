import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/payer/payer.dart';
import 'payment_details.dart';
import 'callbacks.dart';

part 'screenless_payment.g.dart';

/// Class responsible for storing information about
/// [paymentDetails], [payer] and [callbacks].
@JsonSerializable(createToJson: false)
class ScreenlessPayment {
  final PaymentDetails paymentDetails;
  final Payer payer;
  final Callbacks? callbacks;

  ScreenlessPayment({
    required this.paymentDetails,
    required this.payer,
    this.callbacks
  });

  factory ScreenlessPayment.fromJson(Map<String, dynamic> json) => _$ScreenlessPaymentFromJson(json);
}