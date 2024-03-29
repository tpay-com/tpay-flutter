// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentChannel _$PaymentChannelFromJson(Map<String, dynamic> json) =>
    PaymentChannel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      constraints: (json['constraints'] as List<dynamic>)
          .map((e) => PaymentConstraint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentChannelToJson(PaymentChannel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'constraints': instance.constraints,
    };
