// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payer_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayerContext _$PayerContextFromJson(Map<String, dynamic> json) => PayerContext(
      payer: json['payer'] == null
          ? null
          : Payer.fromJson(json['payer'] as Map<String, dynamic>),
      automaticPaymentMethods: json['automaticPaymentMethods'] == null
          ? null
          : AutomaticPaymentMethods.fromJson(
              json['automaticPaymentMethods'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayerContextToJson(PayerContext instance) =>
    <String, dynamic>{
      'payer': instance.payer?.toJson(),
      'automaticPaymentMethods': instance.automaticPaymentMethods?.toJson(),
    };
