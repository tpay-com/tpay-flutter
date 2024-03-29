import 'package:json_annotation/json_annotation.dart';

import '../paymentChannel/payment_channel.dart';

part 'payment_channels_result.g.dart';

/// Indicates a result of payment channels
abstract class PaymentChannelsResult {}

/// Indicates that payment channels were successfully received
/// - [channels] - Payment channels
@JsonSerializable()
class PaymentChannelsSuccess extends PaymentChannelsResult {
  final List<PaymentChannel> channels;

  PaymentChannelsSuccess({
    required this.channels,
  });

  factory PaymentChannelsSuccess.fromJson(Map<String, dynamic> json) => _$PaymentChannelsSuccessFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentChannelsSuccessToJson(this);
}

/// Indicates that there was an error while fetching payment channels
/// - [message] - Error message
class PaymentChannelsError extends PaymentChannelsResult {
  final String message;

  PaymentChannelsError({required this.message});
}
