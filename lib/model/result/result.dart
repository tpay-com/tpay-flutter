
/// Indicates result of a Tpay UI module action
abstract class Result { }

/// Indicates that credit card tokenization
/// was successful and module was closed
class TokenizationCompleted extends Result { }

/// Indicates that credit card tokenization
/// failed and module was closed
class TokenizationFailure extends Result { }

/// Indicates that configuration was successful
class ConfigurationSuccess extends Result { }

/// Indicates that user closed the module
/// without making a payment/tokenization
class ModuleClosed extends Result { }

/// Indicates that some data passed
/// to module is invalid
class ValidationError extends Result {
  final String message;

  ValidationError(this.message);
}

/// Indicates that payment was successfully created
class PaymentCreated extends Result {
  final String transactionId;

  PaymentCreated(this.transactionId);
}

/// Indicates that payment was successful
/// and module was closed
class PaymentCompleted extends Result {
  final String transactionId;

  PaymentCompleted(this.transactionId);
}

/// Indicates that payment failed
/// and module was closed
class PaymentCancelled extends Result {
  final String? transactionId;

  PaymentCancelled(this.transactionId);
}

/// Indicates plugin error
class MethodCallError extends Result {
  final String message;

  MethodCallError(this.message);
}