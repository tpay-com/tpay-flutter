import 'package:json_annotation/json_annotation.dart';
import 'language.dart';

part 'languages.g.dart';

/// Class responsible for storing information about module languages.
/// Module will open in [preferredLanguage]. User will be able to change
/// language to one of [supportedLanguages].
@JsonSerializable()
class Languages {
  final Language preferredLanguage;
  final List<Language> supportedLanguages;

  Languages({required this.preferredLanguage, required this.supportedLanguages});

  factory Languages.fromJson(Map<String, dynamic> json) => _$LanguagesFromJson(json);
  Map<String, dynamic> toJson() => _$LanguagesToJson(this);
}