import 'package:json_annotation/json_annotation.dart';
import 'payment_method.dart';
import 'digital_wallet.dart';

part 'payment_methods.g.dart';

/// Class responsible for storing payment [methods] and digital [wallets]
/// selected by merchant.
@JsonSerializable(explicitToJson: true)
class PaymentMethods {
  final List<PaymentMethod> methods;
  final List<DigitalWallet>? wallets;

  PaymentMethods({
    required this.methods,
    this.wallets
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => _$PaymentMethodsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}