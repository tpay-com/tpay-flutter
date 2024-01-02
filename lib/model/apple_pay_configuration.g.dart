// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_pay_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplePayConfiguration _$ApplePayConfigurationFromJson(
        Map<String, dynamic> json) =>
    ApplePayConfiguration(
      merchantIdentifier: json['merchantIdentifier'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$ApplePayConfigurationToJson(
        ApplePayConfiguration instance) =>
    <String, dynamic>{
      'merchantIdentifier': instance.merchantIdentifier,
      'countryCode': instance.countryCode,
    };
