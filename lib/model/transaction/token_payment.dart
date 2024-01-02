import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/transaction/transaction.dart';
import '../payer/payer.dart';
import '../screenless/notifications.dart';

part 'token_payment.g.dart';

/// Class responsible for storing information about
/// credit card token payment with Tpay UI module.
/// - [amount] - amount of money payer has to pay
/// - [description] - description of payment shown to payer
/// - [cardToken] - token of tokenized card (for returning customers)
@JsonSerializable(explicitToJson: true)
class TokenPayment extends Transaction {
  final Payer payer;
  final String cardToken;

  TokenPayment({
    required super.amount,
    required super.description,
    required this.payer,
    required this.cardToken,
    super.notifications
  });

  factory TokenPayment.fromJson(Map<String, dynamic> json) => _$TokenPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$TokenPaymentToJson(this);
}