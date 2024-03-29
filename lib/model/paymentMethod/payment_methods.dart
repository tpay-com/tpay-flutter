import 'package:json_annotation/json_annotation.dart';
import 'installment_payment.dart';
import 'payment_method.dart';
import 'digital_wallet.dart';

part 'payment_methods.g.dart';

/// Class responsible for storing payment [methods], digital [wallets]
/// and [installmentPayments] selected by merchant.
@JsonSerializable(explicitToJson: true)
class PaymentMethods {
  final List<PaymentMethod> methods;
  final List<DigitalWallet>? wallets;
  final List<InstallmentPayment>? installmentPayments;

  PaymentMethods({
    required this.methods,
    this.wallets,
    this.installmentPayments,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => _$PaymentMethodsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}