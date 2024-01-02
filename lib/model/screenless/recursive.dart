import 'package:json_annotation/json_annotation.dart';

part 'recursive.g.dart';

/// Class responsible for storing information about recurring payments
/// - [frequency] - how often payment should be repeated
/// - [quantity] - how many times payment should be repeated. If null, [quantity] = infinity
/// - [endDate] - date in yyyy-MM-dd format
@JsonSerializable(explicitToJson: true)
class Recursive {
  late final Frequency frequency;
  late final int? quantity;
  final String endDate;

  Recursive({
    required this.frequency,
    required this.quantity,
    required this.endDate
  });

  factory Recursive.fromJson(Map<String, dynamic> json) => _$RecursiveFromJson(json);
  Map<String, dynamic> toJson() => _$RecursiveToJson(this);
}

enum Frequency {
  @JsonValue(1)
  daily,

  @JsonValue(2)
  weekly,

  @JsonValue(3)
  monthly,

  @JsonValue(4)
  quarterly,

  @JsonValue(5)
  yearly
}