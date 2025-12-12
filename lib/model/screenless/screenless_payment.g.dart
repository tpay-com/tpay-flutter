// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screenless_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenlessPayment _$ScreenlessPaymentFromJson(Map<String, dynamic> json) =>
    ScreenlessPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      callbacks: Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
    );
