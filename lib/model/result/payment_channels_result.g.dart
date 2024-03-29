// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_channels_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentChannelsSuccess _$PaymentChannelsSuccessFromJson(
        Map<String, dynamic> json) =>
    PaymentChannelsSuccess(
      channels: (json['channels'] as List<dynamic>)
          .map((e) => PaymentChannel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentChannelsSuccessToJson(
        PaymentChannelsSuccess instance) =>
    <String, dynamic>{
      'channels': instance.channels,
    };
