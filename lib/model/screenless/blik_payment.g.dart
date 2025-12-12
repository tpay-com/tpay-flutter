// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blik_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BLIKPayment _$BLIKPaymentFromJson(Map<String, dynamic> json) => BLIKPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      callbacks: Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
      code: json['code'] as String?,
      alias: json['alias'] == null
          ? null
          : BlikAlias.fromJson(json['alias'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BLIKPaymentToJson(BLIKPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails.toJson(),
      'payer': instance.payer.toJson(),
      'callbacks': instance.callbacks.toJson(),
      'code': instance.code,
      'alias': instance.alias?.toJson(),
    };
