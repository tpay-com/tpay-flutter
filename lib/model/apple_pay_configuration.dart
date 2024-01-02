import 'package:json_annotation/json_annotation.dart';

part 'apple_pay_configuration.g.dart';

/// Class responsible for storing information about Apple Pay configuration.
/// - [merchantIdentifier] - unique id that identifies your business as a merchant able to accept apple payments
/// - [countryCode] - country code, for example "PL"
@JsonSerializable()
class ApplePayConfiguration {
  final String merchantIdentifier;
  final String countryCode;

  ApplePayConfiguration({required this.merchantIdentifier, required this.countryCode});

  factory ApplePayConfiguration.fromJson(Map<String, dynamic> json) => _$ApplePayConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ApplePayConfigurationToJson(this);
}