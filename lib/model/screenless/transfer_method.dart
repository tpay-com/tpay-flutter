import 'package:json_annotation/json_annotation.dart';

part 'transfer_method.g.dart';

/// Class responsible for storing information about
/// single transfer method
/// - [id] - group id used to create payment with this method
/// - [name] - name of bank
/// - [imageUrl] - image url of bank logo
@JsonSerializable(explicitToJson: true)
class TransferMethod {
  const TransferMethod({
    required this.id,
    required this.name,
    required this.imageUrl
  });

  final String id;
  final String name;
  final String imageUrl;

  factory TransferMethod.fromJson(Map<String, dynamic> json) => _$TransferMethodFromJson(json);
  Map<String, dynamic> toJson() => _$TransferMethodToJson(this);
}