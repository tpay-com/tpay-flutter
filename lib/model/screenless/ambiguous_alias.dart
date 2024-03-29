import 'package:json_annotation/json_annotation.dart';

part 'ambiguous_alias.g.dart';

/// Class responsible for storing ambiguous alias information
/// - [name] - alias display name
/// - [code] - alias identifier
@JsonSerializable()
class AmbiguousAlias {
  final String name;
  final String code;

  AmbiguousAlias({
    required this.name,
    required this.code,
  });

  factory AmbiguousAlias.fromJson(Map<String, dynamic> json) => _$AmbiguousAliasFromJson(json);
  Map<String, dynamic> toJson() => _$AmbiguousAliasToJson(this);
}