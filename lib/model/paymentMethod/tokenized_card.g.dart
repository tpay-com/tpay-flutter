// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokenized_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenizedCard _$TokenizedCardFromJson(Map<String, dynamic> json) =>
    TokenizedCard(
      token: json['token'] as String,
      cardTail: json['cardTail'] as String,
      brand: $enumDecode(_$CreditCardBrandEnumMap, json['brand']),
    );

Map<String, dynamic> _$TokenizedCardToJson(TokenizedCard instance) =>
    <String, dynamic>{
      'token': instance.token,
      'cardTail': instance.cardTail,
      'brand': _$CreditCardBrandEnumMap[instance.brand]!,
    };

const _$CreditCardBrandEnumMap = {
  CreditCardBrand.mastercard: 'mastercard',
  CreditCardBrand.visa: 'visa',
  CreditCardBrand.unknown: 'unknown',
};
