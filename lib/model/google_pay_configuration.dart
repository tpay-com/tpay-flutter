import 'package:json_annotation/json_annotation.dart';

part 'google_pay_configuration.g.dart';

/// Class responsible for storing information about GooglePay configuration
/// - [merchantId] - your merchant id in Tpay system
@JsonSerializable()
class GooglePayConfiguration {
  final String merchantId;

  GooglePayConfiguration({required this.merchantId});

  factory GooglePayConfiguration.fromJson(Map<String, dynamic> json) => _$GooglePayConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$GooglePayConfigurationToJson(this);
}