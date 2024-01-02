import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';
import '../payer/payer.dart';
import '../paymentMethod/blik_alias.dart';
import 'callbacks.dart';

part 'blik_payment.g.dart';

/// Class responsible for storing information about
/// BLIK payment. You have to provide either [code] or [alias].
/// - [code] - 6 digit value
/// - [alias] - BLIK alias (for returning users)
@JsonSerializable(explicitToJson: true)
class BLIKPayment extends ScreenlessPayment {
  final String? code;
  final BlikAlias? alias;

  BLIKPayment({
    required super.paymentDetails,
    required super.payer,
    super.callbacks,
    this.code,
    this.alias
  });

  factory BLIKPayment.fromJson(Map<String, dynamic> json) => _$BLIKPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$BLIKPaymentToJson(this);
}