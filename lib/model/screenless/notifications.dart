import 'package:json_annotation/json_annotation.dart';

part 'notifications.g.dart';

/// Class responsible for storing information
/// about notification [url] and [email]
/// - [url] - url for payment/tokenization notifications
/// - [email] - email for payment notifications
@JsonSerializable()
class Notifications {
  final String url;
  final String email;

  Notifications({
    required this.url,
    required this.email
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}