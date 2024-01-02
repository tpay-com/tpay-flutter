

abstract class GooglePayConfigureResult { }

class GooglePayConfigureSuccess extends GooglePayConfigureResult { }

class GooglePayConfigureError extends GooglePayConfigureResult {
  final String message;

  GooglePayConfigureError(this.message);
}