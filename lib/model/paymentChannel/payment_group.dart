import 'package:json_annotation/json_annotation.dart';

part 'payment_group.g.dart';

/// Class responsible for storing payment group's information
/// - [id] - id of the group
/// - [name] - group's display name
/// - [imageUrl] - group's image url
@JsonSerializable()
class PaymentGroup {
  final String id;
  final String name;
  final String imageUrl;

  PaymentGroup({
   required this.id,
   required this.name,
   required this.imageUrl,
  });

  factory PaymentGroup.fromJson(Map<String, dynamic> json) => _$PaymentGroupFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentGroupToJson(this);
}