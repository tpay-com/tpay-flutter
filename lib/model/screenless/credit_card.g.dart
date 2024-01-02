// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) => CreditCard(
      cardNumber: json['cardNumber'] as String,
      expiryDate:
          ExpirationDate.fromJson(json['expiryDate'] as Map<String, dynamic>),
      cvv: json['cvv'] as String,
      config: CreditCardConfig.fromJson(json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate.toJson(),
      'cvv': instance.cvv,
      'config': instance.config.toJson(),
    };
