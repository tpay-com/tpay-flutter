import 'dart:convert';
import 'package:flutter_tpay/model/result/google_pay_configure_result.dart';

const type = "type";
const success = "success";
const error = "error";
const message = "message";
const unknownGooglePayConfigurationResult = "Unknown Google Pay configuration result";

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