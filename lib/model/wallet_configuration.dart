import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/apple_pay_configuration.dart';
import 'package:flutter_tpay/model/google_pay_configuration.dart';

part 'wallet_configuration.g.dart';

/// Class responsible for storing wallet configuration.
@JsonSerializable(explicitToJson: true)
class WalletConfiguration {
  final GooglePayConfiguration googlePay;
  final ApplePayConfiguration applePay;

  WalletConfiguration({required this.googlePay, required this.applePay});

  factory WalletConfiguration.fromJson(Map<String, dynamic> json) => _$WalletConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$WalletConfigurationToJson(this);
}