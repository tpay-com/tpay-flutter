// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardConfig _$CreditCardConfigFromJson(Map<String, dynamic> json) =>
    CreditCardConfig(
      shouldSave: json['shouldSave'] as bool,
      domain: json['domain'] as String,
      rocText: json['rocText'] as String?,
    );

Map<String, dynamic> _$CreditCardConfigToJson(CreditCardConfig instance) =>
    <String, dynamic>{
      'shouldSave': instance.shouldSave,
      'domain': instance.domain,
      'rocText': instance.rocText,
    };
