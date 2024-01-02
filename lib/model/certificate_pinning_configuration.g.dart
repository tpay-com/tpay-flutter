// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_pinning_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificatePinningConfiguration _$CertificatePinningConfigurationFromJson(
        Map<String, dynamic> json) =>
    CertificatePinningConfiguration(
      publicKeyHash: json['publicKeyHash'] as String,
    )..pinnedDomain = json['pinnedDomain'] as String;

Map<String, dynamic> _$CertificatePinningConfigurationToJson(
        CertificatePinningConfiguration instance) =>
    <String, dynamic>{
      'pinnedDomain': instance.pinnedDomain,
      'publicKeyHash': instance.publicKeyHash,
    };
