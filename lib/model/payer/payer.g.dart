// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payer _$PayerFromJson(Map<String, dynamic> json) => Payer(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayerToJson(Payer instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address?.toJson(),
    };
