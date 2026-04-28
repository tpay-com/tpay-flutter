## 1.2.15
- Change: Updated iOS SDK to 1.3.16
- Change: Updated Android SDK to 1.2.8
- Feature: Added a "back" button (chevron) on the 3DS screen during card tokenization on iOS — analogous to Android
- Fix: Fixed isRegistered flag mapping in BlikAlias on iOS — the alias registration checkbox is now displayed correctly
- Fix: Fixed handling of empty blikAliasToRegister — an empty string no longer creates an alias
- Fix: Fixed payment screen presentation with FlutterSceneDelegate (iOS 13+)

## 1.2.14
- Change: Updated iOS SDK to 1.3.12

## 1.2.13
- Change: Updated iOS SDK to 1.3.11

## 1.2.12
- Change: Updated Android SDK to 1.2.7
- Fix: Correct supported languages configuration

## 1.2.11
- Change: Updated iOS SDK to 1.3.10
- Change: Updated Android SDK to 1.2.6
- Fix: Presentation sheet not showing

## 1.2.10
- Change: Updated iOS SDK to 1.3.9
- Fix: Payers information reset on language change on iOS
- Fix: Lack of redirection for token transactions on iOS

## 1.2.9
- Change: Updated iOS SDK to 1.3.8
- Fix: Using callbacks internally to configure notifications & redirects

## 1.2.8
- Change: Updated iOS SDK to 1.3.7
- Fix: Passing success & error redirect urls to the API on Screenless transaction creation on iOS

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
