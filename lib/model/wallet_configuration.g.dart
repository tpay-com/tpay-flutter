// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletConfiguration _$WalletConfigurationFromJson(Map<String, dynamic> json) =>
    WalletConfiguration(
      googlePay: json['googlePay'] == null
          ? null
          : GooglePayConfiguration.fromJson(
              json['googlePay'] as Map<String, dynamic>),
      applePay: json['applePay'] == null
          ? null
          : ApplePayConfiguration.fromJson(
              json['applePay'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WalletConfigurationToJson(
        WalletConfiguration instance) =>
    <String, dynamic>{
      'googlePay': instance.googlePay?.toJson(),
      'applePay': instance.applePay?.toJson(),
    };
