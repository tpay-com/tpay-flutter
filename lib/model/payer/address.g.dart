// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address: json['address'] as String?,
      city: json['city'] as String?,
      countryCode: json['countryCode'] as String?,
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'countryCode': instance.countryCode,
      'postalCode': instance.postalCode,
    };
