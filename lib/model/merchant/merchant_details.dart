import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/language/localized_string.dart';

part 'merchant_details.g.dart';

/// Class responsible for storing merchant [merchantDisplayName], [merchantHeadquarters] and [regulations] urls.
@JsonSerializable(explicitToJson: true)
class MerchantDetails {
  final List<LocalizedString> merchantDisplayName;
  final List<LocalizedString> merchantHeadquarters;
  final List<LocalizedString> regulations;

  MerchantDetails({
    required this.merchantDisplayName,
    required this.merchantHeadquarters,
    required this.regulations
  });

  factory MerchantDetails.fromJson(Map<String, dynamic> json) => _$MerchantDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MerchantDetailsToJson(this);
}