// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokenization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tokenization _$TokenizationFromJson(Map<String, dynamic> json) => Tokenization(
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      notificationUrl: json['notificationUrl'] as String,
    );

Map<String, dynamic> _$TokenizationToJson(Tokenization instance) =>
    <String, dynamic>{
      'payer': instance.payer.toJson(),
      'notificationUrl': instance.notificationUrl,
    };
