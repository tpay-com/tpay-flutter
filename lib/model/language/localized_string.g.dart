// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localized_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizedString _$LocalizedStringFromJson(Map<String, dynamic> json) =>
    LocalizedString(
      language: $enumDecode(_$LanguageEnumMap, json['language']),
      value: json['value'] as String,
    );

Map<String, dynamic> _$LocalizedStringToJson(LocalizedString instance) =>
    <String, dynamic>{
      'language': _$LanguageEnumMap[instance.language]!,
      'value': instance.value,
    };

const _$LanguageEnumMap = {
  Language.pl: 'pl',
  Language.en: 'en',
};
