// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_pay_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplePayPayment _$ApplePayPaymentFromJson(Map<String, dynamic> json) =>
    ApplePayPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      applePayToken: json['applePayToken'] as String,
      callbacks: json['callbacks'] == null
          ? null
          : Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplePayPaymentToJson(ApplePayPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails.toJson(),
      'payer': instance.payer.toJson(),
      'callbacks': instance.callbacks?.toJson(),
      'applePayToken': instance.applePayToken,
    };
