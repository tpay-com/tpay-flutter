import 'package:json_annotation/json_annotation.dart';

part 'payment_constraint.g.dart';

const _type = "type";
const _amount = "AMOUNT";
const _minimum = "minimum";
const _maximum = "maximum";
const _errorMessage = "Unknown payment constraint type";

/// Class indicating that there is a payment constraint on a payment channel
/// - [type] - type of a payment constraint
@JsonSerializable(createFactory: false)
class PaymentConstraint {
  final PaymentConstraintType type;

  PaymentConstraint(this.type);

  static PaymentConstraint _fromCustomJson(Map<String, dynamic> json) {
    switch (json[_type]) {
      case _amount:
        return AmountPaymentConstraint(
          minimum: json[_minimum]?.toDouble(),
          maximum: json[_maximum]?.toDouble(),
        );
      default:
        throw Exception(_errorMessage);
    }
  }

  factory PaymentConstraint.fromJson(Map<String, dynamic> json) => _fromCustomJson(json);
  Map<String, dynamic> toJson() => _$PaymentConstraintToJson(this);
}

/// Enum describing available payment constraint types
enum PaymentConstraintType {
  amount,
}

/// Class responsible for storing information about amount payment constraint
/// - [minimum] - minimum price that can be used while creating the transaction
/// - [maximum] - maximum price that can be used while creating the transaction
class AmountPaymentConstraint extends PaymentConstraint {
  final double? minimum;
  final double? maximum;

  AmountPaymentConstraint({required this.minimum, required this.maximum}) : super(PaymentConstraintType.amount);
}
