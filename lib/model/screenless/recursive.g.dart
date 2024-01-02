// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recursive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recursive _$RecursiveFromJson(Map<String, dynamic> json) => Recursive(
      frequency: $enumDecode(_$FrequencyEnumMap, json['frequency']),
      quantity: json['quantity'] as int?,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$RecursiveToJson(Recursive instance) => <String, dynamic>{
      'frequency': _$FrequencyEnumMap[instance.frequency]!,
      'quantity': instance.quantity,
      'endDate': instance.endDate,
    };

const _$FrequencyEnumMap = {
  Frequency.daily: 1,
  Frequency.weekly: 2,
  Frequency.monthly: 3,
  Frequency.quarterly: 4,
  Frequency.yearly: 5,
};
