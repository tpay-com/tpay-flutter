import 'package:json_annotation/json_annotation.dart';
import 'tokenized_card.dart';
import 'blik_alias.dart';

part 'automatic_payment_methods.g.dart';

/// Class responsible for storing information about [tokenizedCards]
/// and [blikAlias].
@JsonSerializable(explicitToJson: true)
class AutomaticPaymentMethods {
  final List<TokenizedCard>? tokenizedCards;
  final BlikAlias? blikAlias;

  AutomaticPaymentMethods({required this.tokenizedCards, required this.blikAlias});

  factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) => _$AutomaticPaymentMethodsFromJson(json);
  Map<String, dynamic> toJson() => _$AutomaticPaymentMethodsToJson(this);
}