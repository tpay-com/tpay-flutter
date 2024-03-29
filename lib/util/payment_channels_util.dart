import 'dart:convert';

import 'package:flutter_tpay/model/result/payment_channels_result.dart';

const success = "success";
const error = "error";
const unknownType = "Unknown result type";
const language = "language";
const currency = "currency";
const channels = "channels";
const message = "message";
const type = "type";

PaymentChannelsResult mapPaymentChannelsResult(String json) {
  final map = jsonDecode(json);
  switch (map[type]) {
    case success:
      return PaymentChannelsSuccess.fromJson(map);
    case error:
      return PaymentChannelsError(message: map[message]);
    default:
      throw Exception(unknownType);
  }
}
