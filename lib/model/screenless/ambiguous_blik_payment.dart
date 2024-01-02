import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/paymentMethod/blik_alias.dart';
import 'package:flutter_tpay/model/screenless/ambiguous_alias.dart';

part 'ambiguous_blik_payment.g.dart';

/// Class responsible for storing information about ambiguous BLIK payment.
/// - [transactionId] - id of transaction received from ScreenlessBlikAmbiguousAlias result
/// - [blikAlias] - alias used to create BLIK one click payment that returned ScreenlessBlikAmbiguousAlias result
/// - [ambiguousAlias] - ambiguous alias selected by user from list provided by ScreenlessBlikAmbiguousAlias result
@JsonSerializable(explicitToJson: true)
class AmbiguousBLIKPayment {
  final String transactionId;
  final BlikAlias blikAlias;
  final AmbiguousAlias ambiguousAlias;

  AmbiguousBLIKPayment({
    required this.transactionId,
    required this.blikAlias,
    required this.ambiguousAlias
  });

  factory AmbiguousBLIKPayment.fromJson(Map<String, dynamic> json) => _$AmbiguousBLIKPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$AmbiguousBLIKPaymentToJson(this);
}