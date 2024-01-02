import 'package:json_annotation/json_annotation.dart';

part 'redirects.g.dart';

/// Class responsible for storing information about redirect urls
/// - [successUrl] - payer will be redirected to this url after successful payment
/// - [errorUrl] - payer will be redirected to this url after unsuccessful payment
@JsonSerializable()
class Redirects {
  final String successUrl;
  final String errorUrl;

  Redirects({
    required this.successUrl,
    required this.errorUrl
  });

  factory Redirects.fromJson(Map<String, dynamic> json) => _$RedirectsFromJson(json);
  Map<String, dynamic> toJson() => _$RedirectsToJson(this);
}