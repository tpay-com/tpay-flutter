import 'package:json_annotation/json_annotation.dart';

part 'certificate_pinning_configuration.g.dart';

/// Class responsible for storing information about certificate pinning.
/// - [publicKeyHash] - public key used to encrypt credit card
/// data during payment/tokenization.
@JsonSerializable()
class CertificatePinningConfiguration {
  String pinnedDomain = "api.tpay.com";
  final String publicKeyHash;

  CertificatePinningConfiguration({required this.publicKeyHash});

  factory CertificatePinningConfiguration.fromJson(Map<String, dynamic> json) => _$CertificatePinningConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$CertificatePinningConfigurationToJson(this);
}