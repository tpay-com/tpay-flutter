import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/expiration_date.dart';
import 'credit_card_config.dart';

part 'credit_card.g.dart';

/// Class responsible for storing basic credit card information like
/// [cardNumber], [expiryDate], [cvv].
@JsonSerializable(explicitToJson: true)
class CreditCard {
  final String cardNumber;
  final ExpirationDate expiryDate;
  final String cvv;
  final CreditCardConfig config;

  CreditCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.config
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) => _$CreditCardFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardToJson(this);
}