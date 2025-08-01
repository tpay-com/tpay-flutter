import 'package:json_annotation/json_annotation.dart';
import '../screenless/notifications.dart';

part 'transaction.g.dart';

/// Class responsible for storing information about transaction [amount] and
/// [description].
@JsonSerializable(createToJson: false)
class Transaction {
  final double amount;
  final String description;
  final String? hiddenDescription;
  final Notifications? notifications;

  Transaction({
    required this.amount,
    required this.description,
    this.hiddenDescription,
    this.notifications
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}