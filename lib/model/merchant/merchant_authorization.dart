import 'package:json_annotation/json_annotation.dart';

part 'merchant_authorization.g.dart';

/// Class responsible for storing merchant's [clientId] and [clientSecret].
@JsonSerializable()
class MerchantAuthorization {
  final String clientId;
  final String clientSecret;

  MerchantAuthorization({
    required this.clientId,
    required this.clientSecret
  });

  factory MerchantAuthorization.fromJson(Map<String, dynamic> json) => _$MerchantAuthorizationFromJson(json);
  Map<String, dynamic> toJson() => _$MerchantAuthorizationToJson(this);
}