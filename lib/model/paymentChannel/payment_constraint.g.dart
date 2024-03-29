// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_constraint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentConstraint _$PaymentConstraintFromJson(Map<String, dynamic> json) =>
    PaymentConstraint(
      $enumDecode(_$PaymentConstraintTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PaymentConstraintToJson(PaymentConstraint instance) =>
    <String, dynamic>{
      'type': _$PaymentConstraintTypeEnumMap[instance.type]!,
    };

const _$PaymentConstraintTypeEnumMap = {
  PaymentConstraintType.amount: 'amount',
};
