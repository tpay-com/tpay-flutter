// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardPayment _$CreditCardPaymentFromJson(Map<String, dynamic> json) =>
    CreditCardPayment(
      paymentDetails: PaymentDetails.fromJson(
          json['paymentDetails'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      callbacks: json['callbacks'] == null
          ? null
          : Callbacks.fromJson(json['callbacks'] as Map<String, dynamic>),
      creditCard: json['creditCard'] == null
          ? null
          : CreditCard.fromJson(json['creditCard'] as Map<String, dynamic>),
      creditCardToken: json['creditCardToken'] as String?,
      recursive: json['recursive'] == null
          ? null
          : Recursive.fromJson(json['recursive'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditCardPaymentToJson(CreditCardPayment instance) =>
    <String, dynamic>{
      'paymentDetails': instance.paymentDetails.toJson(),
      'payer': instance.payer.toJson(),
      'callbacks': instance.callbacks?.toJson(),
      'creditCard': instance.creditCard?.toJson(),
      'creditCardToken': instance.creditCardToken,
      'recursive': instance.recursive?.toJson(),
    };
