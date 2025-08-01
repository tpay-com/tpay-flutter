// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleTransaction _$SingleTransactionFromJson(Map<String, dynamic> json) =>
    SingleTransaction(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      payerContext:
          PayerContext.fromJson(json['payerContext'] as Map<String, dynamic>),
      hiddenDescription: json['hiddenDescription'] as String?,
      notifications: json['notifications'] == null
          ? null
          : Notifications.fromJson(
              json['notifications'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleTransactionToJson(SingleTransaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'hiddenDescription': instance.hiddenDescription,
      'notifications': instance.notifications?.toJson(),
      'payerContext': instance.payerContext.toJson(),
    };
