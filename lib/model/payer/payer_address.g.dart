// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payer_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayerAddress _$PayerAddressFromJson(Map<String, dynamic> json) => PayerAddress(
      address: json['address'] as String?,
      city: json['city'] as String?,
      countryCode: json['countryCode'] as String?,
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$PayerAddressToJson(PayerAddress instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'countryCode': instance.countryCode,
      'postalCode': instance.postalCode,
    };
