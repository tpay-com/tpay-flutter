import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/payer/payer.dart';
import 'package:flutter_tpay/model/paymentMethod/automatic_payment_methods.dart';

part 'payer_context.g.dart';

/// Class responsible for storing [payer] and his [automaticPaymentMethods].
@JsonSerializable(explicitToJson: true)
class PayerContext {
  final Payer? payer;
  final AutomaticPaymentMethods? automaticPaymentMethods;

  PayerContext({required this.payer, required this.automaticPaymentMethods});

  factory PayerContext.fromJson(Map<String, dynamic> json) => _$PayerContextFromJson(json);
  Map<String, dynamic> toJson() => _$PayerContextToJson(this);
}