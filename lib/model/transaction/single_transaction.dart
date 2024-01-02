import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/payer/payer_context.dart';
import 'package:flutter_tpay/model/transaction/transaction.dart';

import '../screenless/notifications.dart';

part 'single_transaction.g.dart';

/// Class responsible for storing information about standard Tpay UI module payment
/// - [amount] - amount of money payer has to pay
/// - [description] - description of payment shown to payer
/// - [payerContext] - information about payer and automatic payment methods
@JsonSerializable(explicitToJson: true)
class SingleTransaction extends Transaction {
  final PayerContext payerContext;

  SingleTransaction({
    required super.amount,
    required super.description,
    required this.payerContext,
    super.notifications
  });

  factory SingleTransaction.fromJson(Map<String, dynamic> json) => _$SingleTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$SingleTransactionToJson(this);
}