import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tpay/model/screenless/payment_details.dart';
import 'package:flutter_tpay/model/screenless/screenless_payment.dart';
import '../payer/payer.dart';
import 'callbacks.dart';

part 'transfer_payment.g.dart';

/// Class responsible for storing information about transfer payment
/// - [channelId] - id of bank in tpay system
@JsonSerializable()
class TransferPayment extends ScreenlessPayment {
  final int channelId;

  TransferPayment({
    required super.paymentDetails,
    required super.payer,
    required super.callbacks,
    required this.channelId
  });

  factory TransferPayment.fromJson(Map<String, dynamic> json) => _$TransferPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$TransferPaymentToJson(this);
}