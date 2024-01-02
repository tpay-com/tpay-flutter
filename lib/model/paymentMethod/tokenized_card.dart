import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/paymentMethod/credit_card_brand.dart';

part 'tokenized_card.g.dart';

/// Class responsible for storing credit card's [token], [cardTail] and
/// card [brand].
@JsonSerializable(explicitToJson: true)
class TokenizedCard {
  final String token;
  final String cardTail;
  final CreditCardBrand brand;

  TokenizedCard({
    required this.token,
    required this.cardTail,
    required this.brand
  });

  factory TokenizedCard.fromJson(Map<String, dynamic> json) => _$TokenizedCardFromJson(json);
  Map<String, dynamic> toJson() => _$TokenizedCardToJson(this);
}