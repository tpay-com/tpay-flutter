import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Class responsible for storing payer address.
@JsonSerializable()
class Address {
  final String? address;
  final String? city;
  final String? countryCode;
  final String? postalCode;

  Address({
    required this.address,
    required this.city,
    required this.countryCode,
    required this.postalCode
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}