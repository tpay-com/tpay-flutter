import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/credit_card.dart';
import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/recursive.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';

import '../payer/payer.dart';
import 'callbacks.dart';

part 'credit_card_payment.g.dart';

/// Class responsible for storing information about
/// credit card payment. You have to provide either [creditCard]
/// or [creditCardToken].
/// - [creditCard] - information about credit card
/// - [creditCardToken] - token of tokenized card (for returning customers)
/// - [recursive] - if present creates a recurring payment
@JsonSerializable(explicitToJson: true)
class CreditCardPayment extends ScreenlessPayment {
  final CreditCard? creditCard;
  final String? creditCardToken;
  final Recursive? recursive;

  CreditCardPayment({
    required super.paymentDetails,
    required super.payer,
    required super.callbacks,
    this.creditCard,
    this.creditCardToken,
    this.recursive
  });

  factory CreditCardPayment.fromJson(Map<String, dynamic> json) => _$CreditCardPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardPaymentToJson(this);
}