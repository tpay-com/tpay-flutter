import 'package:json_annotation/json_annotation.dart';

part 'payer_address.g.dart';

/// Class responsible for storing payer address.
@JsonSerializable()
class PayerAddress {
  final String? address;
  final String? city;
  final String? countryCode;
  final String? postalCode;

  PayerAddress({
    required this.address,
    required this.city,
    required this.countryCode,
    required this.postalCode
  });

  factory PayerAddress.fromJson(Map<String, dynamic> json) => _$PayerAddressFromJson(json);
  Map<String, dynamic> toJson() => _$PayerAddressToJson(this);
}