// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_pay_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePayPayment _$GooglePayPaymentFromJson(Map<String, dynamic> json) =>
    GooglePayPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      token: json['token'] as String,
      callbacks: json['callbacks'] == null
          ? null
          : Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GooglePayPaymentToJson(GooglePayPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails.toJson(),
      'payer': instance.payer.toJson(),
      'callbacks': instance.callbacks?.toJson(),
      'token': instance.token,
    };
