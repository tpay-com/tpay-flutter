
import '../screenless/ambiguous_alias.dart';

/// Indicates result of a screenless payment
abstract class ScreenlessResult { }

/// Indicates that some data passed
/// to payment is invalid
class ScreenlessValidationError extends ScreenlessResult {
  final String message;

  ScreenlessValidationError(this.message);
}

/// Indicates that payment was completed successfully
class ScreenlessPaid extends ScreenlessResult {
  final String transactionId;

  ScreenlessPaid({required this.transactionId});
}

/// Indicates that payment was created.
/// If it was a credit card or transfer payment you might
/// have to display [paymentUrl] to the user to finish the payment.
/// If it was a BLIK payment user has to accept it in bank app.
/// It is advised to use long polling mechanism to observe
/// payment status via [transactionId].
class ScreenlessPaymentCreated extends ScreenlessResult {
  final String transactionId;
  final String? paymentUrl;

  ScreenlessPaymentCreated({
    required this.transactionId,
    this.paymentUrl
  });
}

/// Indicates that creating payment failed because of error with:
/// - credit card data or credit card token
/// - BLIK code or BLIK alias
class ScreenlessConfiguredPaymentFailed extends ScreenlessResult {
  final String transactionId;
  final String? error;

  ScreenlessConfiguredPaymentFailed({
    required this.transactionId,
    this.error
  });
}

class ScreenlessBlikAmbiguousAlias extends ScreenlessResult {
  final String transactionId;
  final List<AmbiguousAlias> aliases;

  ScreenlessBlikAmbiguousAlias({
    required this.transactionId,
    required this.aliases,
  });
}

/// Indicates that payment was not created because of error
class ScreenlessPaymentError extends ScreenlessResult {
  final String? error;

  ScreenlessPaymentError(this.error);
}

/// Indicates plugin error
class ScreenlessMethodCallError extends ScreenlessResult {
  final String message;

  ScreenlessMethodCallError({ required this.message });
}
