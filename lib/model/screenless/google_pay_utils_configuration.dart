import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/google_pay_environment.dart';

part 'google_pay_utils_configuration.g.dart';

/// Class responsible for storing information
/// about Google Pay utils configuration.
/// - [price] - price that will be displayed in Google Pay
/// - [merchantName] - store name displayed in Google Pay
/// - [merchantId] - your merchantId in Tpay system
/// - [environment] - Google Pay environment
/// - [customRequestCode] - alternative request code that will be used to manage Google Pay data
@JsonSerializable(explicitToJson: true)
class GooglePayUtilsConfiguration {
  final double price;
  final String merchantName;
  final String merchantId;
  final GooglePayEnvironment environment;
  final int? customRequestCode;

  GooglePayUtilsConfiguration({
    required this.price,
    required this.merchantName,
    required this.merchantId,
    required this.environment,
    this.customRequestCode
  });

  factory GooglePayUtilsConfiguration.fromJson(Map<String, dynamic> json) => _$GooglePayUtilsConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$GooglePayUtilsConfigurationToJson(this);
}