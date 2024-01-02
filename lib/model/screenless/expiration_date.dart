import 'package:json_annotation/json_annotation.dart';

part 'expiration_date.g.dart';

/// Class responsible for storing expiration date information
@JsonSerializable()
class ExpirationDate {
  final String month;
  final String year;

  ExpirationDate({required this.month, required this.year});

  factory ExpirationDate.fromJson(Map<String, dynamic> json) => _$ExpirationDateFromJson(json);
  Map<String, dynamic> toJson() => _$ExpirationDateToJson(this);
}