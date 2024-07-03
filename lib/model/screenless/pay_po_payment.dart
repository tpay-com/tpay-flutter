import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';
import 'package:json_annotation/json_annotation.dart';

import '../payer/payer.dart';
import 'callbacks.dart';

part 'pay_po_payment.g.dart';

/// Class responsible for storing information about PayPo payment
@JsonSerializable()
class PayPoPayment extends ScreenlessPayment {
  PayPoPayment({
    required super.paymentDetails,
    required super.payer,
    required super.callbacks
  });

  factory PayPoPayment.fromJson(Map<String, dynamic> json) => _$PayPoPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PayPoPaymentToJson(this);
}