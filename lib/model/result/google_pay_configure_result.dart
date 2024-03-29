/// Indicates a result of Google Pay utils configuration
abstract class GooglePayConfigureResult { }

/// Indicates that Google Pay configuration was successful
class GooglePayConfigureSuccess extends GooglePayConfigureResult { }

/// Indicates that there was an error during Google Pay configuration
/// - [message] - error message
class GooglePayConfigureError extends GooglePayConfigureResult {
  final String message;

  GooglePayConfigureError(this.message);
}