import 'dart:convert';
import '../model/result/result.dart';

const type = "type";
const value = "value";
const configurationSuccess = "configurationSuccess";
const validationError = "validationError";
const paymentCompleted = "paymentCompleted";
const paymentCancelled = "paymentCancelled";
const tokenizationCompleted = "tokenizationCompleted";
const tokenizationFailure = "tokenizationFailure";
const methodCallError = "methodCallError";
const moduleClosed = "moduleClosed";
const unknownResult = "Unknown result type";

Result mapResult(String json) {
  final map = jsonDecode(json);
  switch (map[type]) {
    case configurationSuccess:
      return ConfigurationSuccess();
    case validationError:
      return ValidationError(map[value]);
    case paymentCompleted:
      return PaymentCompleted(map[value]);
    case paymentCancelled:
      return PaymentCancelled(map[value]);
    case tokenizationCompleted:
      return TokenizationCompleted();
    case tokenizationFailure:
      return TokenizationFailure();
    case methodCallError:
      return MethodCallError(map[value]);
    case moduleClosed:
      return ModuleClosed();
    default:
      throw Exception(unknownResult);
  }
}