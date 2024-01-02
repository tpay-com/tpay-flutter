// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tpay_screenless_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TpayScreenlessConfiguration _$TpayScreenlessConfigurationFromJson(
        Map<String, dynamic> json) =>
    TpayScreenlessConfiguration(
      authorization: MerchantAuthorization.fromJson(
          json['authorization'] as Map<String, dynamic>),
      certificatePinningConfiguration: CertificatePinningConfiguration.fromJson(
          json['certificatePinningConfiguration'] as Map<String, dynamic>),
      environment: $enumDecode(_$TpayEnvironmentEnumMap, json['environment']),
    );

Map<String, dynamic> _$TpayScreenlessConfigurationToJson(
        TpayScreenlessConfiguration instance) =>
    <String, dynamic>{
      'authorization': instance.authorization.toJson(),
      'certificatePinningConfiguration':
          instance.certificatePinningConfiguration.toJson(),
      'environment': _$TpayEnvironmentEnumMap[instance.environment]!,
    };

const _$TpayEnvironmentEnumMap = {
  TpayEnvironment.production: 'production',
  TpayEnvironment.sandbox: 'sandbox',
};
