// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Languages _$LanguagesFromJson(Map<String, dynamic> json) => Languages(
      preferredLanguage:
          $enumDecode(_$LanguageEnumMap, json['preferredLanguage']),
      supportedLanguages: (json['supportedLanguages'] as List<dynamic>)
          .map((e) => $enumDecode(_$LanguageEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$LanguagesToJson(Languages instance) => <String, dynamic>{
      'preferredLanguage': _$LanguageEnumMap[instance.preferredLanguage]!,
      'supportedLanguages': instance.supportedLanguages
          .map((e) => _$LanguageEnumMap[e]!)
          .toList(),
    };

const _$LanguageEnumMap = {
  Language.pl: 'pl',
  Language.en: 'en',
};
