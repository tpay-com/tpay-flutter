## UNRELEASED

## 1.2.7
- Fix: Updated iOS SDK to version 1.3.6 to support exact channel in screenless mode for `TransferPayment`
- Change: Updated iOS SDK to version 1.3.6 to handle passing `notifications` parameter
- Fix: Screenless payments parsing on iOS
- Change: Screenless payments now ___REQUIRES___ `callbacks` to be provided

## 1.2.6
- Updated README.md file with improved documentation

## 1.2.5
- Updated iOS SDK to version 1.3.4 to fix crash

## 1.2.4
- Updated Android SDK to version 1.2.3 to handle hiddenDescription parameter
- Added support for the hiddenDescription parameter
- Fixed getAvailablePaymentChannels method on iOS
- Standardized returned results for card token payments on iOS
- Updated the example

## 1.2.3
- Updated iOS SDK to version 1.3.2 to handle payment module close callback

## 1.2.2
- Update android sdk to 1.2.2 to prevent bug in PayPo, where country code is not preselected 

## 1.2.1
- Fixed compatibility with AGP 8.0+
- Correct handling of the onPaymentCreated callback

## 1.2.0
- Add onPaymentCreated callback with transactionId

## 1.1.1
- Fixed payment module results handling

## 1.1.0
- PayPo payment method added

## 1.0.0
- First release
