import 'package:json_annotation/json_annotation.dart';
import '../language/language.dart';

part 'payment_details.g.dart';

/// Class responsible for storing information about payment
/// - [amount] - amount of money payer has to pay
/// - [description] - description of payment shown to payer
/// - [hiddenDescription] - description visible to store
/// - [language] - language of transaction
@JsonSerializable(explicitToJson: true)
class PaymentDetails {
  final double amount;
  final String description;
  final String? hiddenDescription;
  final Language? language;

  PaymentDetails({
    required this.amount,
    required this.description,
    this.hiddenDescription,
    this.language
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => _$PaymentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentDetailsToJson(this);
}