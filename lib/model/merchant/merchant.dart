import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/certificate_pinning_configuration.dart';
import 'package:flutter_tpay/model/merchant/merchant_authorization.dart';
import 'package:flutter_tpay/model/tpay_environment.dart';
import 'package:flutter_tpay/model/wallet_configuration.dart';

part 'merchant.g.dart';

/// Class responsible for storing merchant information.
/// - [authorization] - credentials
/// - [environment] - environment that the plugin will use
/// - [certificatePinningConfiguration] - encryption information
/// - [blikAliasToRegister] - BLIK that will be registered with payment
/// - [walletConfiguration] - configuration of digital wallets
@JsonSerializable(explicitToJson: true)
class Merchant {
  final MerchantAuthorization authorization;
  final TpayEnvironment environment;
  final CertificatePinningConfiguration certificatePinningConfiguration;
  final String blikAliasToRegister;
  final WalletConfiguration walletConfiguration;

  Merchant({
    required this.authorization,
    required this.environment,
    required this.certificatePinningConfiguration,
    required this.blikAliasToRegister,
    required this.walletConfiguration
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => _$MerchantFromJson(json);
  Map<String, dynamic> toJson() => _$MerchantToJson(this);
}