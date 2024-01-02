import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/language/languages.dart';
import 'package:flutter_tpay/model/merchant/merchant.dart';
import 'package:flutter_tpay/model/merchant/merchant_details.dart';
import 'package:flutter_tpay/model/paymentMethod/payment_methods.dart';

part 'tpay_configuration.g.dart';

/// Class responsible for storing information about Tpay configuration.
/// - [merchant] - configuration information about merchant
/// - [merchantDetails] - information about merchant in different languages
/// - [languages] - languages that user will be able to use in Tpay UI module
/// - [paymentMethods] - payment methods that user will be able to use in Tpay UI module
@JsonSerializable(explicitToJson: true)
class TpayConfiguration {
  final Merchant merchant;
  final MerchantDetails merchantDetails;
  final Languages languages;
  final PaymentMethods paymentMethods;

  TpayConfiguration({
    required this.merchant,
    required this.merchantDetails,
    required this.languages,
    required this.paymentMethods,
  });

  factory TpayConfiguration.fromJson(Map<String, dynamic> json) => _$TpayConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$TpayConfigurationToJson(this);
}