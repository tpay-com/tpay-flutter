import 'package:flutter_tpay/model/paymentChannel/payment_constraint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_channel.g.dart';

/// Class responsible for storing information about a payment channel
/// - [id] - id of the payment channel
/// - [name] - channel display name
/// - [imageUrl] - channel image url
/// - [constraints] - channel constraints
@JsonSerializable()
class PaymentChannel {
  final String id;
  final String name;
  final String imageUrl;
  final List<PaymentConstraint> constraints;

  PaymentChannel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.constraints,
  });

  factory PaymentChannel.fromJson(Map<String, dynamic> json) => _$PaymentChannelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentChannelToJson(this);
}