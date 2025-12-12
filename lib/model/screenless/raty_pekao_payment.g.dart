// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raty_pekao_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatyPekaoPayment _$RatyPekaoPaymentFromJson(Map<String, dynamic> json) =>
    RatyPekaoPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      callbacks: Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
      channelId: (json['channelId'] as num).toInt(),
    );

Map<String, dynamic> _$RatyPekaoPaymentToJson(RatyPekaoPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails,
      'payer': instance.payer,
      'callbacks': instance.callbacks,
      'channelId': instance.channelId,
    };
