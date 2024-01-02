// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferPayment _$TransferPaymentFromJson(Map<String, dynamic> json) =>
    TransferPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      callbacks: json['callbacks'] == null
          ? null
          : Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
      groupId: json['groupId'] as int,
      bankName: json['bankName'] as String,
    );

Map<String, dynamic> _$TransferPaymentToJson(TransferPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails,
      'payer': instance.payer,
      'callbacks': instance.callbacks,
      'groupId': instance.groupId,
      'bankName': instance.bankName,
    };
