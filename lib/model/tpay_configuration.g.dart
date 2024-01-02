// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tpay_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TpayConfiguration _$TpayConfigurationFromJson(Map<String, dynamic> json) =>
    TpayConfiguration(
      merchant: Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
      merchantDetails: MerchantDetails.fromJson(
          json['merchantDetails'] as Map<String, dynamic>),
      languages: Languages.fromJson(json['languages'] as Map<String, dynamic>),
      paymentMethods: PaymentMethods.fromJson(
          json['paymentMethods'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TpayConfigurationToJson(TpayConfiguration instance) =>
    <String, dynamic>{
      'merchant': instance.merchant.toJson(),
      'merchantDetails': instance.merchantDetails.toJson(),
      'languages': instance.languages.toJson(),
      'paymentMethods': instance.paymentMethods.toJson(),
    };
