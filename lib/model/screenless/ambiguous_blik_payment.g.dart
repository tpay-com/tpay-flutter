// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambiguous_blik_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmbiguousBLIKPayment _$AmbiguousBLIKPaymentFromJson(
        Map<String, dynamic> json) =>
    AmbiguousBLIKPayment(
      transactionId: json['transactionId'] as String,
      blikAlias: BlikAlias.fromJson(json['blikAlias'] as Map<String, dynamic>),
      ambiguousAlias: AmbiguousAlias.fromJson(
          json['ambiguousAlias'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AmbiguousBLIKPaymentToJson(
        AmbiguousBLIKPayment instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'blikAlias': instance.blikAlias.toJson(),
      'ambiguousAlias': instance.ambiguousAlias.toJson(),
    };
