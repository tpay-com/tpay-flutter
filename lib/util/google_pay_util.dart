import 'dart:convert';
import 'package:flutter_tpay/model/result/google_pay_configure_result.dart';
import 'package:flutter_tpay/model/result/google_pay_open_result.dart';

const type = "type";
const success = "success";
const error = "error";
const message = "message";
const unknownGooglePayConfigurationResult = "Unknown Google Pay configuration result";
const cancelled = "cancelled";
const unknownError = "unknownError";
const notConfigured = "notConfigured";
const token = "token";
const description = "description";
const cardNetwork = "cardNetwork";
const cardTail = "cardTail";

GooglePayConfigureResult mapGooglePayConfigurationResult(String json) {
  final map = jsonDecode(json);
  switch (map[type]) {
    case success:
      return GooglePayConfigureSuccess();
    case error:
      return GooglePayConfigureError(map[message]);
    default:
      throw Exception(unknownGooglePayConfigurationResult);
  }
}

GooglePayOpenResult mapGooglePayOpenResult(String json) {
  final map = jsonDecode(json);
  switch (map[type]) {
    case success:
      return GooglePayOpenSuccess(
        token: map[token],
        description: map[description],
        cardNetwork: map[cardNetwork],
        cardTail: map[cardTail]
      );
    case cancelled:
      return GooglePayOpenCancelled();
    case unknownError:
      return GooglePayOpenUnknownError();
    default:
      return GooglePayOpenNotConfigured();
  }
}

