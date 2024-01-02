// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAuthorization _$MerchantAuthorizationFromJson(
        Map<String, dynamic> json) =>
    MerchantAuthorization(
      clientId: json['clientId'] as String,
      clientSecret: json['clientSecret'] as String,
    );

Map<String, dynamic> _$MerchantAuthorizationToJson(
        MerchantAuthorization instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };
