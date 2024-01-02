// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callbacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Callbacks _$CallbacksFromJson(Map<String, dynamic> json) => Callbacks(
      redirects: json['redirects'] == null
          ? null
          : Redirects.fromJson(json['redirects'] as Map<String, dynamic>),
      notifications: json['notifications'] == null
          ? null
          : Notifications.fromJson(
              json['notifications'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CallbacksToJson(Callbacks instance) => <String, dynamic>{
      'redirects': instance.redirects?.toJson(),
      'notifications': instance.notifications?.toJson(),
    };
