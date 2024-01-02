// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_methods_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodsSuccess _$PaymentMethodsSuccessFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodsSuccess(
      isCreditCardPaymentAvailable:
          json['isCreditCardPaymentAvailable'] as bool,
      isBLIKPaymentAvailable: json['isBLIKPaymentAvailable'] as bool,
      availableTransferMethods:
          (json['availableTransferMethods'] as List<dynamic>)
              .map((e) => TransferMethod.fromJson(e as Map<String, dynamic>))
              .toList(),
      availableDigitalWallets:
          (json['availableDigitalWallets'] as List<dynamic>)
              .map((e) => $enumDecode(_$DigitalWalletEnumMap, e))
              .toList(),
    );

Map<String, dynamic> _$PaymentMethodsSuccessToJson(
        PaymentMethodsSuccess instance) =>
    <String, dynamic>{
      'isCreditCardPaymentAvailable': instance.isCreditCardPaymentAvailable,
      'isBLIKPaymentAvailable': instance.isBLIKPaymentAvailable,
      'availableTransferMethods':
          instance.availableTransferMethods.map((e) => e.toJson()).toList(),
      'availableDigitalWallets': instance.availableDigitalWallets
          .map((e) => _$DigitalWalletEnumMap[e]!)
          .toList(),
    };

const _$DigitalWalletEnumMap = {
  DigitalWallet.googlePay: 'googlePay',
  DigitalWallet.applePay: 'applePay',
};
