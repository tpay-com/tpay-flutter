// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_methods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      methods: (json['methods'] as List<dynamic>)
          .map((e) => $enumDecode(_$PaymentMethodEnumMap, e))
          .toList(),
      wallets: (json['wallets'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DigitalWalletEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'methods':
          instance.methods.map((e) => _$PaymentMethodEnumMap[e]!).toList(),
      'wallets':
          instance.wallets?.map((e) => _$DigitalWalletEnumMap[e]!).toList(),
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.blik: 'blik',
  PaymentMethod.transfer: 'transfer',
  PaymentMethod.card: 'card',
};

const _$DigitalWalletEnumMap = {
  DigitalWallet.googlePay: 'googlePay',
  DigitalWallet.applePay: 'applePay',
};
