import 'dart:convert';
import 'package:flutter_tpay/model/result/screenless_result.dart';
import 'package:flutter_tpay/model/screenless/ambiguous_alias.dart';

const type = "type";
const paid = "paid";
const configuredPaymentFailed = "configuredPaymentFailed";
const ambiguousAlias = "ambiguousAlias";
const aliases = "aliases";
const error = "error";
const paymentCreated = "paymentCreated";
const validationError = "validationError";
const methodCallError = "methodCallError";
const transactionId = "transactionId";
const message = "message";
const paymentUrl = "paymentUrl";
const unknownScreenlessResult = "Unknown screenless result type";

ScreenlessResult mapScreenlessResult(String json) {
  final map = jsonDecode(json);
  switch (map[type]) {
    case paid:
      return ScreenlessPaid(transactionId: map[transactionId]);
    case configuredPaymentFailed:
      return ScreenlessConfiguredPaymentFailed(
        transactionId: map[transactionId],
        error: map[message]
      );
    case paymentCreated:
      return ScreenlessPaymentCreated(
        transactionId: map[transactionId],
        paymentUrl: map[paymentUrl]
      );
    case ambiguousAlias:
      return ScreenlessBlikAmbiguousAlias(
        transactionId: map[transactionId],
        aliases: List<AmbiguousAlias>.from(map[aliases].map((e) => AmbiguousAlias.fromJson(e as Map<String, dynamic>)))
      );
    case methodCallError:
      return ScreenlessMethodCallError(message: map[message]);
    case error:
      return ScreenlessPaymentError(map[message]);
    case validationError:
      return ScreenlessValidationError(map[message]);
    default:
      throw Exception(unknownScreenlessResult);
  }
}