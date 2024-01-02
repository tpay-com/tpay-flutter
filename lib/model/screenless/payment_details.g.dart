// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDetails _$PaymentDetailsFromJson(Map<String, dynamic> json) =>
    PaymentDetails(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      hiddenDescription: json['hiddenDescription'] as String?,
      language: $enumDecodeNullable(_$LanguageEnumMap, json['language']),
    );

Map<String, dynamic> _$PaymentDetailsToJson(PaymentDetails instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'hiddenDescription': instance.hiddenDescription,
      'language': _$LanguageEnumMap[instance.language],
    };

const _$LanguageEnumMap = {
  Language.pl: 'pl',
  Language.en: 'en',
};
