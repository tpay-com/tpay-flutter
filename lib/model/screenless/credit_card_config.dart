import 'package:json_annotation/json_annotation.dart';

part 'credit_card_config.g.dart';

/// Class responsible for storing payment related information
/// about credit card
/// - [shouldSave] - whether credit card should be tokenized after payment
/// - [domain] - domain of your store
@JsonSerializable()
class CreditCardConfig {
  final bool shouldSave;
  final String domain;
  final String? rocText;

  CreditCardConfig({
    required this.shouldSave,
    required this.domain,
    this.rocText
  });

  factory CreditCardConfig.fromJson(Map<String, dynamic> json) => _$CreditCardConfigFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardConfigToJson(this);
}