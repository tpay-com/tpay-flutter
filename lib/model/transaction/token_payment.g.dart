// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPayment _$TokenPaymentFromJson(Map<String, dynamic> json) => TokenPayment(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      cardToken: json['cardToken'] as String,
      notifications: json['notifications'] == null
          ? null
          : Notifications.fromJson(
              json['notifications'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenPaymentToJson(TokenPayment instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'notifications': instance.notifications?.toJson(),
      'payer': instance.payer.toJson(),
      'cardToken': instance.cardToken,
    };
