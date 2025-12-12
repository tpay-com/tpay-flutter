// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_po_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPoPayment _$PayPoPaymentFromJson(Map<String, dynamic> json) => PayPoPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      callbacks: Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayPoPaymentToJson(PayPoPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails,
      'payer': instance.payer,
      'callbacks': instance.callbacks,
    };
