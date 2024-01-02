// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_payment_methods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutomaticPaymentMethods _$AutomaticPaymentMethodsFromJson(
        Map<String, dynamic> json) =>
    AutomaticPaymentMethods(
      tokenizedCards: (json['tokenizedCards'] as List<dynamic>?)
          ?.map((e) => TokenizedCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      blikAlias: json['blikAlias'] == null
          ? null
          : BlikAlias.fromJson(json['blikAlias'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutomaticPaymentMethodsToJson(
        AutomaticPaymentMethods instance) =>
    <String, dynamic>{
      'tokenizedCards':
          instance.tokenizedCards?.map((e) => e.toJson()).toList(),
      'blikAlias': instance.blikAlias?.toJson(),
    };
