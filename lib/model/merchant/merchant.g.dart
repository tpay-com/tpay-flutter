// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
      authorization: MerchantAuthorization.fromJson(
          json['authorization'] as Map<String, dynamic>),
      environment: $enumDecode(_$TpayEnvironmentEnumMap, json['environment']),
      certificatePinningConfiguration: CertificatePinningConfiguration.fromJson(
          json['certificatePinningConfiguration'] as Map<String, dynamic>),
      blikAliasToRegister: json['blikAliasToRegister'] as String,
      walletConfiguration: WalletConfiguration.fromJson(
          json['walletConfiguration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'authorization': instance.authorization.toJson(),
      'environment': _$TpayEnvironmentEnumMap[instance.environment]!,
      'certificatePinningConfiguration':
          instance.certificatePinningConfiguration.toJson(),
      'blikAliasToRegister': instance.blikAliasToRegister,
      'walletConfiguration': instance.walletConfiguration.toJson(),
    };

const _$TpayEnvironmentEnumMap = {
  TpayEnvironment.production: 'production',
  TpayEnvironment.sandbox: 'sandbox',
};
