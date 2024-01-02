import 'package:json_annotation/json_annotation.dart';
import 'address.dart';

part 'payer.g.dart';

/// Class responsible for storing payer information.
@JsonSerializable(explicitToJson: true)
class Payer {
  final String name;
  final String email;
  final String? phone;
  final Address? address;

  Payer({
    required this.name,
    required this.email,
    required this.phone,
    required this.address
  });

  factory Payer.fromJson(Map<String, dynamic> json) => _$PayerFromJson(json);
  Map<String, dynamic> toJson() => _$PayerToJson(this);
}