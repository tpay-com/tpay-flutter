// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantDetails _$MerchantDetailsFromJson(Map<String, dynamic> json) =>
    MerchantDetails(
      merchantDisplayName: (json['merchantDisplayName'] as List<dynamic>)
          .map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
          .toList(),
      merchantHeadquarters: (json['merchantHeadquarters'] as List<dynamic>)
          .map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
          .toList(),
      regulations: (json['regulations'] as List<dynamic>)
          .map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MerchantDetailsToJson(MerchantDetails instance) =>
    <String, dynamic>{
      'merchantDisplayName':
          instance.merchantDisplayName.map((e) => e.toJson()).toList(),
      'merchantHeadquarters':
          instance.merchantHeadquarters.map((e) => e.toJson()).toList(),
      'regulations': instance.regulations.map((e) => e.toJson()).toList(),
      'merchantCities': instance.regulations.map((e) => e.toJson()).toList(),
    };
