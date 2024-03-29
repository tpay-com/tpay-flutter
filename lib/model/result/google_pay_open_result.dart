/// Indicates a result of Google Pay open
abstract class GooglePayOpenResult { }

/// Indicates that payer has chosen credit card and
/// data was received successfully
/// - [token] - information about credit card from Google Pay response
/// - [description] - credit card description, for example "Visa •••• 1111"
/// - [cardNetwork] - credit card network
/// - [cardTail] - last digits of credit card number
class GooglePayOpenSuccess extends GooglePayOpenResult {
  final String token;
  final String description;
  final String cardNetwork;
  final String cardTail;

  GooglePayOpenSuccess({
    required this.token,
    required this.description,
    required this.cardNetwork,
    required this.cardTail,
  });
}

/// Indicates that payer closed the Google Pay module
/// without selecting the credit card
class GooglePayOpenCancelled extends GooglePayOpenResult { }

/// Indicates that there was a error while parsing data or
/// receiving activity result code
class GooglePayOpenUnknownError extends GooglePayOpenResult { }


/// Indicates that GooglePayUtils are not configured.
/// Configure using TpayPlatform.configureGooglePayUtils(...)
class GooglePayOpenNotConfigured extends GooglePayOpenResult { }