import 'package:json_annotation/json_annotation.dart';
import '../payer/payer.dart';

part 'tokenization.g.dart';

/// Class responsible for storing information needed
/// to start UI tokenization.
/// - [payer] - information about payer
/// - [notificationUrl] - url for tokenization notifications
@JsonSerializable(explicitToJson: true)
class Tokenization {
  const Tokenization({required this.payer, required this.notificationUrl});

  final Payer payer;
  final String notificationUrl;

  factory Tokenization.fromJson(Map<String, dynamic> json) => _$TokenizationFromJson(json);
  Map<String, dynamic> toJson() => _$TokenizationToJson(this);
}