import 'package:json_annotation/json_annotation.dart';
import 'redirects.dart';
import 'notifications.dart';

part 'callbacks.g.dart';

/// Class responsible for storing information about
/// [redirects] and [notifications].
@JsonSerializable(explicitToJson: true)
class Callbacks {
  final Redirects? redirects;
  final Notifications? notifications;

  Callbacks({
    this.redirects,
    this.notifications
  });

  factory Callbacks.fromJson(Map<String, dynamic> json) => _$CallbacksFromJson(json);
  Map<String, dynamic> toJson() => _$CallbacksToJson(this);
}