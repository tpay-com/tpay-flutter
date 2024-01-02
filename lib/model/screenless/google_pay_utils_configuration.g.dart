// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_pay_utils_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePayUtilsConfiguration _$GooglePayUtilsConfigurationFromJson(
        Map<String, dynamic> json) =>
    GooglePayUtilsConfiguration(
      price: (json['price'] as num).toDouble(),
      merchantName: json['merchantName'] as String,
      merchantId: json['merchantId'] as String,
      environment:
          $enumDecode(_$GooglePayEnvironmentEnumMap, json['environment']),
      customRequestCode: json['customRequestCode'] as int?,
    );

Map<String, dynamic> _$GooglePayUtilsConfigurationToJson(
        GooglePayUtilsConfiguration instance) =>
    <String, dynamic>{
      'price': instance.price,
      'merchantName': instance.merchantName,
      'merchantId': instance.merchantId,
      'environment': _$GooglePayEnvironmentEnumMap[instance.environment]!,
      'customRequestCode': instance.customRequestCode,
    };

const _$GooglePayEnvironmentEnumMap = {
  GooglePayEnvironment.production: 'production',
  GooglePayEnvironment.test: 'test',
};
