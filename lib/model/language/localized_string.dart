import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/language/language.dart';

part 'localized_string.g.dart';

/// Class responsible for storing [value] and indicating [language].
@JsonSerializable()
class LocalizedString {
  final Language language;
  final String value;

  LocalizedString({required this.language, required this.value});

  factory LocalizedString.fromJson(Map<String, dynamic> json) => _$LocalizedStringFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizedStringToJson(this);
}