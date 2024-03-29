import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';
import 'package:json_annotation/json_annotation.dart';
import '../payer/payer.dart';
import 'callbacks.dart';

part 'raty_pekao_payment.g.dart';

/// Class responsible for storing information about Raty Pekao payment
/// - [channelId] - id of Raty Pekao payment channel
@JsonSerializable()
class RatyPekaoPayment extends ScreenlessPayment {
  final int channelId;

  RatyPekaoPayment({
    required super.paymentDetails,
    required super.payer,
    required super.callbacks,
    required this.channelId,
  });

  factory RatyPekaoPayment.fromJson(Map<String, dynamic> json) => _$RatyPekaoPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$RatyPekaoPaymentToJson(this);
}