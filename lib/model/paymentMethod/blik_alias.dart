import 'package:json_annotation/json_annotation.dart';

part 'blik_alias.g.dart';

/// Class responsible for storing BLIK alias [value] and [label] that is
/// displayed to the payer.
@JsonSerializable()
class BlikAlias {
  final bool isRegistered;
  final String value;
  final String label;

  BlikAlias({
    required this.isRegistered,
    required this.value,
    required this.label
  });

  factory BlikAlias.fromJson(Map<String, dynamic> json) => _$BlikAliasFromJson(json);
  Map<String, dynamic> toJson() => _$BlikAliasToJson(this);
}