import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/tpay_environment.dart';
import 'certificate_pinning_configuration.dart';
import 'merchant/merchant_authorization.dart';

part 'tpay_screenless_configuration.g.dart';

/// Class responsible for storing information about Tpay screenless configuration.
/// - [authorization] - credentials
/// - [certificatePinningConfiguration] - encryption information
/// - [environment] - environment that the plugin will use
@JsonSerializable(explicitToJson: true)
class TpayScreenlessConfiguration {
  final MerchantAuthorization authorization;
  final CertificatePinningConfiguration certificatePinningConfiguration;
  final TpayEnvironment environment;

  TpayScreenlessConfiguration({
    required this.authorization,
    required this.certificatePinningConfiguration,
    required this.environment
  });

  factory TpayScreenlessConfiguration.fromJson(Map<String, dynamic> json) => _$TpayScreenlessConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$TpayScreenlessConfigurationToJson(this);
}