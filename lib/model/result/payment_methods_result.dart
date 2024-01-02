import 'package:json_annotation/json_annotation.dart';
import '../paymentMethod/digital_wallet.dart';
import '../screenless/transfer_method.dart';

part 'payment_methods_result.g.dart';

/// Indicates result of screenless PaymentMethods action
abstract class PaymentMethodsResult { }

/// Indicates that available payment methods were received
/// successfully
@JsonSerializable(explicitToJson: true)
class PaymentMethodsSuccess extends PaymentMethodsResult {
  PaymentMethodsSuccess({
    required this.isCreditCardPaymentAvailable,
    required this.isBLIKPaymentAvailable,
    required this.availableTransferMethods,
    required this.availableDigitalWallets
  });

  final bool isCreditCardPaymentAvailable;
  final bool isBLIKPaymentAvailable;
  final List<TransferMethod> availableTransferMethods;
  final List<DigitalWallet> availableDigitalWallets;

  factory PaymentMethodsSuccess.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsSuccessToJson(this);
}

/// Indicates that there was a error while fetching
/// available payment methods
class PaymentMethodsError extends PaymentMethodsResult {
  PaymentMethodsError(this.devErrorMessage);

  final String devErrorMessage;
}