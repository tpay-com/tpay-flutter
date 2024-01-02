import 'dart:convert';
import 'package:flutter_tpay/model/result/payment_methods_result.dart';
import 'package:flutter_tpay/util/result_util.dart';

const success = "success";
const error = "error";
const paymentMethods = "paymentMethods";
const devErrorMessage = "devErrorMessage";

PaymentMethodsResult mapPaymentMethodsResult(String json) {
  final map = jsonDecode(json);
  switch (map[type]) {
    case success:
      return PaymentMethodsSuccess.fromJson(map[paymentMethods]);
    case error:
      return PaymentMethodsError(map[devErrorMessage]);
    default:
      throw Exception(unknownResult);
  }
}