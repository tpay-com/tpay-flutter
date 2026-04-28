# Tpay
![Static Badge](https://img.shields.io/badge/flutter->=2.5.0-blue?logo=flutter&label=Flutter)
![Static Badge](https://img.shields.io/badge/dart->=2.18-blue?logo=dart&label=Dart)
![Static Badge](https://img.shields.io/badge/min_android_sdk-23-blue?logo=android&label=Min%20Android%20SDK)
![Static Badge](https://img.shields.io/badge/min_ios_sdk-12.0+-blue?logo=apple&label=iOS)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Table of Contents
- [About](#about)
- [Install](#install)
- [Configuration](#configuration)
- [Handling payments](#handling-payments)
- [Official SDK screens](#official-sdk-screens)
- [Tokenization](#tokenization)
- [Screenless Payments](#screenless-payments)
- [License](#license)

## About
This plugin allows your app to make payments with Tpay.

| Library | Version |
| ------- | ------- |
| Flutter | >=2.5.0 |
| Dart | >=2.18 |
| Minimum Android SDK | 23 (Android 6.0, Marshmallow) |
| Minimum iOS version | 12.0 |

> [!warning]
> For this SDK to work you will need `client_id` and `client_secret` tokens. You can find in [merchant's panel](https://panel.tpay.com).
>
> If you are partner, you can obtain them in your merchant partner account. For detailed
> instructions how to do that or how to create such an account
> check [this site](https://docs-api.tpay.com/en/merchant-accounts/).

> [!tip]
> To be able to test the SDK properly,
> use [mock data](https://support.tpay.com/sprzedawca/srodowisko-testowe-sandbox).

## Install

For details on adding SDK to your app check our [pub.dev page](https://pub.dev/packages/flutter_tpay).

### Run sample application
```bash
git clone <github-link> tpay
cd tpay/example
flutter run
```

## Configuration

> [!note]
> In this section we will provide examples for each configuration to the TpayConfiguration class
> you will be able to make.

> [!important]
> Beneath you will find all configurations that are **MANDATORY**.

### Initialization

At first, you have to configure your app to be able to make any requests by providing SDK info about
your merchant account.
Info about `client_id` and `client_secret` you will find in your merchant's panel at `Integration -> API`.

```dart
MerchantAuthorization(
  clientId: "YOUR_CLIENT_ID", 
  clientSecret: "YOUR_CLIENT_SECRET"
)
```

### Environment

Tpay SDK provides two types of environments you can use in your app:

* `TpayEnvironment.sandbox` - used only for tests and in stage/dev flavor.
* `TpayEnvironment.production` - used for production flavors.

### Payment methods

For users to be able to use a specific payment method you have declared it in the configuration.

| Method                      | Description |
|-----------------------------| ----------- |
| BLIK                        | [Web docs](https://docs-api.tpay.com/en/payment-methods/blik/) |
| Pbl **(Pay-By-Link)**       | [Web docs](https://docs-api.tpay.com/en/payment-methods/pbl/) |
| Card                        | [Web docs](https://docs-api.tpay.com/en/payment-methods/cards/) |
| DigitalWallets              | [GOOGLE_PAY](https://docs-api.tpay.com/en/payment-methods/google-pay/) ; [APPLE_PAY](https://docs-api.tpay.com/en/payment-methods/apple-pay/) |
| InstallmentPayments         | [RATY_PEKAO](https://docs-api.tpay.com/en/payment-methods/installments/) |
| DeferredPayments **(BNPL)** | [PAY_PO](https://docs-api.tpay.com/en/payment-methods/bnpl/) |

```dart
PaymentMethods(  
  methods: [
    PaymentMethod.card, 
    PaymentMethod.blik, 
    PaymentMethod.transfer
  ],  
  wallets: [
    DigitalWallet.applePay, 
    DigitalWallet.googlePay
  ],
  installmentPayments: [
    InstallmentPayment.ratyPekao,
    InstallmentPayment.payPo
  ]
)
```

#### Card

If you decide to enable the credit card payment option, you have to provide SSL certificates.

> [!tip]
> You can find SSL public key on you merchant panel at section `Integrations -> API -> Cards API`.

> [!tip]
> You can find public key on you merchant panel:
> - Acquirer Elavon: `Credit card payments -> API`
> - Acquirer Pekao: `Integrations -> API -> Cards API`

```dart
CertificatePinningConfiguration(publicKeyHash: "PUBLIC_KEY_HASH")
```

#### Google Pay configuration

In order to be able to use Google Pay method you have to provide your `merchant_id` to the SDK.

```dart
GooglePayConfiguration(merchantId: "MERCHANT_ID")
```

`merchant_id` is unique identifier assigned to you during Tpay account registration.

#### Apple Pay configuration

In order to be able to use Apple Pay method you have to provide your `merchant_id` and `country_code` to the SDK.

> [!Warning]
> - Apple Pay is available exclusively on Apple devices (iPhone, iPad, MacBook, iMac). Payments cannot be made on non-Apple operating systems such as Android or Windows.
> - Apple Pay supports only **Visa** and **Mastercard**.

> [!important]
> Before using Apple Pay, make sure the following prerequisites are met:
> - Card payments are enabled in your merchant account.
> - Apple Pay payment channel is activated in your merchant panel.

> [!important]
> To set up Apple Pay, you need an Apple Developer account. Follow these steps:
> 1. Log in to your Apple Developer account.
> 2. Navigate to the `Certificates, Identifiers & Profiles` section.
> 3. Under `Identifiers,` select `Merchant IDs.`
> 4. Click the `+` button to create a new Merchant ID.
> 5. Fill in the required information and associate it with your app's Bundle ID.
> 6. Set up a **Payment Processing Certificate** for the Merchant ID.
> 7. Once created, the merchant identifier can be found in the list of Merchant IDs.
> 8. For more details, please follow [Apple Pay documentation](https://developer.apple.com/documentation/passkit/apple_pay/setting_up_apple_pay).

```dart
ApplePayConfiguration(merchantIdentifier: "merchant_id", countryCode: "PL")
```

### Languages

Tpay SDK lets you decide what languages will be available in the Tpay's screen and which one of them
will be preferred/default.

Right now, SDK allows you to use 2 languages:

* `Language.pl` - polish
* `Language.en` - english

```dart
Languages(preferredLanguage: Language.pl, supportedLanguages: [Language.pl, Language.en])
```

### Merchant details

As a merchant, you can configure how information about you will be shown.
You can set up your `display name`, `city/headquarters` and `regulations link`.

```dart
MerchantDetails(
  merchantDisplayName: [
    LocalizedString(language: Language.pl, value: "polish name"),
    LocalizedString(language: Language.en, value: "english name"),
  ],
  merchantHeadquarters: [
    LocalizedString(language: Language.pl, value: "polish city name"),
    LocalizedString(language: Language.en, value: "english city name"),
  ],
  regulations: [
    LocalizedString(language: Language.pl, value: "polish regulation URL"),
    LocalizedString(language: Language.en, value: "english regulation URL"),
  ],
),
```

### Summary
Beneath you will find how a complete configuration should look like.

```dart
final configuration = TpayConfiguration(  
  merchant: Merchant(
    authorization: MerchantAuthorization(
      clientId: "YOUR_CLIENT_ID", 
      clientSecret: "YOUR_CLIENT_SECRET"
    ),
    environment: TpayEnvironment.sandbox,
    certificatePinningConfiguration: CertificatePinningConfiguration(publicKeyHash: "PUBLIC_KEY_HASH"),
    blikAliasToRegister: "BLIK alias",
    walletConfiguration: WalletConfiguration(
      googlePay: GooglePayConfiguration(merchantId: "YOUR_MERCHANT_ID"),
      applePay: ApplePayConfiguration(merchantIdentifier: "MERCHANT_IDENTIFIER", countryCode: "PL")
    ),
  ), 
  merchantDetails: MerchantDetails(
    merchantDisplayName: [  
      LocalizedString(language: Language.pl, value: "polish name"),  
      LocalizedString(language: Language.en, value: "english name")  
    ],
    merchantHeadquarters: [
      LocalizedString(language: Language.pl, value: "polish city name"),
      LocalizedString(language: Language.en, value: "english city name")
    ],
    regulations: [  
      LocalizedString(language: Language.pl, value: "polish regulation URL"),  
      LocalizedString(language: Language.en, value: "english regulation URL")  
    ],  
  ),  
  languages: Languages(  
    preferredLanguage: Language.pl,  
    supportedLanguages: [Language.pl, Language.en]  
  ),  
  paymentMethods: PaymentMethods(  
    methods: [
      PaymentMethod.card, 
      PaymentMethod.blik, 
      PaymentMethod.transfer
    ],  
    wallets: [
      DigitalWallet.applePay, 
      DigitalWallet.googlePay
    ],
    installmentPayments: [
      InstallmentPayment.ratyPekao, 
      InstallmentPayment.payPo
    ]
  ),
);  

tpay.configure(configuration);
```

### Android
Tpay UI module requires your MainActivity to extend FlutterFragmentActivity and to pass system backpress events.

```kotlin
class MainActivity: FlutterFragmentActivity() {
    override fun onBackPressed() {
        if (TpayBackpressUtil.isModuleVisible) {
            TpayBackpressUtil.onBackPressed()
        } else {
            super.onBackPressed()
        }
    }
}
```

#### Proguard/R8

If you are using Proguard/R8 in your project, you have to add the following rules to the
`android/app/proguard-rules.pro` file, to keep Tpay SDK classes.

```proguard
# Keep all Tpay sdk classes
-keep class com.tpay.sdk.** { *; }
```

### IOS

When integrating the Tpay payment module into your app, it’s important to ensure that the necessary permissions are correctly set up to ensure a smooth user experience.
The module allows the user to automatically fill the credit card form for secure payment processing. This feature requires you to setup the “Privacy - Camera Usage Description” in your app’s Info.plist file.

Integration Steps:
1. Open your project’s Info.plist file.
2. Add the key-value pair for the “Privacy - Camera Usage Description” permission, explaining the purpose of camera access. Clearly state that the camera is used to facilitate the automatic filling of the credit card form for secure payment processing.

Example:
```
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to automatically fill the credit card form for secure payment processing.</string>
```

## Handling payments

Tpay SDK provides two ways of handling payments:

- `Official SDK screens` - you can use Tpay's official screens where you just need to provide "soft"
  information, like price, description or payer info.
- `Screenless` - you can use screenless functionalities, where you set callbacks for payments and
  display all necessary information on your own screens.

## Official SDK screens

To make integration with the SDK faster, we created 3 types of sheets that can be used to handle
payments:

* `SingleTransaction` - the most simple screen where the user can choose any payment method and proceed with it,
* `Tokenization` - screen that handles generating payment token from the credit card,
* `TokenPayment` - screen that handles payment with previously created token for credit card,

### SingleTransaction

SingleTransaction flow opens a UI module and allows the customer to pick one of teh defined payment methods.
This method requires setting up a few things in order to fulfill payment:

* `amount` - simply the price of the transaction
* `description` - transaction description
* `hiddenDescription` (optional) - description visible only to the merchant
* `payerContext` - information about payer
    * `payer` - information about the person who is making the payment
        * `name` - payer name
        * `email` - payer email
        * `phone` - payer phone number
        * `address` - payer address
            * `city` - city name
            * `countryCode` - country code in ISO 3166-1 alpha-2 format
            * `address` - street address
            * `postalCode` - postal code
    * `automaticPaymentMethods` - configuration of automatic payments
        * `tokenizedCards` - previously saved credit cards
            * `token` - card token
            * `cardTails` - last 4 digits of the card
            * `brand` - card brand
        * `blikAlias` - previously saved BLIK alias
            * `value` - alias value
            * `label` - alias label
* `notifications` - info about where the merchant should be notified about new transactions
    * `notificationEmail` - email address to send notification to
    * `notificationUrl` - URL to send notification to / URL to send tokens for tokenization
* `activity` - activity to associate the view with
* `supportFragmentManager` - fragment manager to associate the view with

```dart
final transaction = SingleTransaction(  
  amount: 19.99,  
  description: "transaction description", 
  hiddenDescription: "Hidden message",
  payerContext: PayerContext(  
    payer: Payer(  
      name: "John Doe",  
      email: "example@example.com",
      phone: "123487123",
      address: PayerAddress(
        address: "Test Street 1",
        city: "Warsaw",
        countryCode: "PL",
        postalCode: "00-007",
      ),
    ),
    automaticPaymentMethods: AutomaticPaymentMethods(  
      tokenizedCards: [  
        TokenizedCard(
          token: "card token", 
          cardTail: "1234", 
	      brand: CreditCardBrand.mastercard
 	    ), 
        TokenizedCard(
          token: "card token", 
          cardTail: "4321", 
          brand: CreditCardBrand.visa
        )  
      ],
      blikAlias: BlikAlias(isRegistered: true, value: "alias value", label: "label")
    )
  ),
  notifications: Notifications(url: "https://yourstore.com", email: "payments@yourstore.com")
);  

tpay.startPayment(
  transaction,
  onPaymentCreated: (transactionId) {
    // The onPaymentCreated optional parameter is a callback function
    // that is triggered when a payment is successfully created.
    // It receives the transactionId as an argument, allowing you to handle the event.
  },
);
```

> [!important]
> Tpay SDK also supports `NFC` and `camera` card scanning:
> * `NFC` - Adding card info during transaction, user can tap on the NFC button.
    Then, if NFC is enabled in device, after holding physical card near the device, SDK will scan
    the card's data and automatically fill the form with it.
> * `Camera` - Adding card info during transaction, user can tap on the camera button.
    Then, if the camera scans card data successfully, form will be filled automatically.

#### Automatic Payments

Using `SingleTransaction` screen you can set up automatic BLIK or card payments.
Thanks to that, user will not have to enter BLIK/card data all over again each time making the
payment.

If user using a card as a payment method will opt-in saving card, on successful payment, on the link
specified as `Notifications -> url` Tpay backend will send information about the saved card token, tail and
brand.
Next, your backend has to send it to you, so you can use this info next time the same user will want
to pay with the card.
When you already have all required information, you can add `automaticPaymentMethods` to the `payerContext`.

```dart
AutomaticPaymentMethods(  
  tokenizedCards: [  
    TokenizedCard(
      token: "card_token", 
      cardTail: "1234", 
      brand: CreditCardBrand.mastercard
    ), 
    TokenizedCard(
      token: "card_token", 
      cardTail: "4321", 
      brand: CreditCardBrand.visa
    )  
  ],
  blikAlias: null
)
```

#### Google Pay on-site configuration

Google Pay on-site is an integration of Google Pay payments that allows customers to pay directly from your mobile application.

Google Pay on-site can be integrated in the following scenarios:

- Android application (native) - Google Pay is launched directly in a native Android mobile application, where the integration is implemented using the Google Pay API for Android.

> [!Warning]
> - The Google Pay on-site method is currently available only for the Pekao acquiring agent. Check whether your card payments are processed through this acquiring agent.
> - Google Pay supports only **Visa** and **Mastercard**.

> [!important]
> Before using Google Pay, make sure the following prerequisites are met:
> - Card payments are enabled in your merchant account.
> - Google Pay payment channel is activated in your merchant panel.

#### Android application (native)

##### Development phase

In order to be able to use Google Pay method you have to:

- add `DigitalWallet.googlePay` to a supported payment list
- provide your `merchant_id` to the SDK as follows

```dart
GooglePayConfiguration(merchantId: "MERCHANT_ID")
```

`merchant_id` is unique identifier assigned to you during Tpay account registration.

##### Production readiness

To correctly launch Google Pay in an Android application, the application should:

- be signed with the application certificate (SHA-256),
- be submitted and configured in the Google Pay & Wallet Console,
- have a correctly configured package name consistent with the application data registered in Google.

Application requirements and environment configuration are described in Google's documentation:

- [App prerequisites (minSdk, distribution via Google Play)](https://developers.google.com/pay/api/android/guides/setup)
- [Application integration approval and publishing process](https://developers.google.com/pay/api/android/guides/test-and-deploy/publish-your-integration)

Google provides a checklist of functional and branding requirements that must be met before publishing the integration:

[Integration checklist](https://developers.google.com/pay/api/android/guides/test-and-deploy/integration-checklist)

## Tokenization

Tpay SDK allows you to make credit card transactions without need of entering card's data each time.
Instead, you can create and use a token, associated with a specific card and user.

> [!important]
> There are 2 types of tokens you can use in transactions.
> * [Simple tokens](https://docs-api.tpay.com/en/tokenization/#tokenization-without-charging) -
    tokens that go with card data upon transaction,
> * [Network tokens](https://docs-api.tpay.com/en/tokenization/#tokenization-plus) -
    tokens that can be used without exposing the card details. Also, this token persists even if
    card expires and the user requests a new one.

> [!warning]
> For recurring payments, you can simply use created token to make transaction without need of user
> interaction.

### Creating card token

> [!warning]
> `notificationUrl` should be the URL handled by your backend, because there will be sent token from
> the successful token creation.

```dart
final payer = Payer(
  name: "John Doe",
  email: "example@example.com",
  phone: "123487123",
  address: PayerAddress(
    address: "Test Street 1",
    city: "Warsaw",
    countryCode: "PL",
    postalCode: "00-007",
  ),
);  

tpay.tokenizeCard(Tokenization(payer: payer, notificationUrl: "https://yourstore.com/notifications"));
```

### Token payment

If you already have card token payment, you can simply proceed with an actual tokenization
transaction.

> [!warning]
> `cardToken` is a token sent to your backend during card tokenization process.

```dart
final tokenPayment = TokenPayment(  
  amount: 5.21,  
  description: "transaction description",  
  cardToken: "card_token",  
  payer: Payer(
    name: "John Doe",
    email: "example@example.com",
    phone: "123487123",
    address: PayerAddress(
      address: "Test Street 1",
      city: "Warsaw",
      countryCode: "PL",
      postalCode: "00-007",
    ),
  ),  
);  

tpay.startCardTokenPayment(tokenPayment);
```

### Common
Each transaction with a predefined screen returns a result
that you can use to either show information to the user or, e.g. log errors.

```dart
void handleResult(Result result) {
  switch (result) {
    case PaymentCompleted():
    // payment completed successfully and Tpay module was closed
      break;
    case PaymentCancelled():
    // payment failed and Tpay module was closed
      break;
    case TokenizationCompleted():
    // tokenization was successful and Tpay module was closed
      break;
    case TokenizationFailure():
    // tokenization failed and Tpay module was closed
      break;
    case ConfigurationSuccess():
    // Tpay module configuration was successful
      break;
    case ValidationError():
    // passed data is incorrect
      break;
    case ModuleClosed():
    // user closed the Tpay module
    // without making a payment or tokenization
      break;
    case MethodCallError():
    // something went wrong with the plugin
      break;
    default:
      break;
  }
}
```

## Screenless Payments

Screenless payments are a special type of payment functionality that gives you the whole power of
payment process, but do not limit you to using predefined Tpay screens.

### Get payment channels

To be able to use screenless functionalities you will need to know which payment methods are
available to your merchant account. To get them, you can simply call `getAvailablePaymentChannels`
method on the `TpayPlatform.instance` and set up result observer for them.

> [!warning]
> Available methods needs to be filtered by the `amount` of the transaction, because some payment
> methods have specific constraints, like minimum or maximum amount.

```dart
void _getPaymentChannels() async {
  final result = await tpay.getAvailablePaymentChannels();
  
  switch (result) {
    case PaymentChannelsSuccess():
      for (var channel in result.channels) {
        for (var constraint in channel.constraints.whereType<AmountPaymentConstraint>()) {
          // filter payment methods by the transaction amount
        }
      }
    case PaymentChannelsError():
      // handle error
      break;
  }
}
```

### Configuration

Before you run any screenless payment we do recommend setting up function to handle specific payment results.
You will need this to be able to monitor each payment status, i.e. it's status in real time. To do so,
create a function, that will accept `ScreenlessResult` as a parameter and handle each of them.

> [!warning]
> Note that long polling mechanism will start only when it's needed:
> - `ScreenlessPaymentCreated`: when payment is created and you have to display payment URL.
> - `ScreenlessBlikAmbiguousAlias`: when payment is created and there are more than one BLIK alias registered,
    > so you have to display them to the user and continue payment with selected one.

```dart
void handleScreenlessResult(ScreenlessResult result) {
  switch (result) {
    case ScreenlessPaid():
    // payment completed successfully
      break;
    case ScreenlessPaymentCreated():
    // payment created, use result.paymentUrl to redirect the user to the payment page
      break;
    case ScreenlessPaymentError():
    // creating payment failed
      break;
    case ScreenlessConfiguredPaymentFailed():
    // creating payment failed because of error with:
    // - credit card data or credit card token
    // - BLIK code or BLIK alias
      break;
    case ScreenlessBlikAmbiguousAlias():
    // single alias has been registered multiple times, use result.aliases to let user choose desired one
      break;
    case ScreenlessValidationError():
    // passed data is incorrect
      break;
    case ScreenlessMethodCallError():
    // something went wrong with the plugin
      break;
    default:
      break;
  }
}
```

### Screenless Credit Card Payment

CreditCardPayment allows you to create payments with credit card data.

```dart
final payment = CreditCardPayment(  
  creditCard: CreditCard(  
    cardNumber: "card number",
    expiryDate: ExpirationDate(
      month: "12",
      year: "24"
    ),  
    cvv: "123",  
    config: CreditCardConfig(
      shouldSave: false,  
      domain: "yourstore.com"  
    )  
  ),
  paymentDetails: PaymentDetails(  
    amount: 19.99,  
    description: "transaction description",  
    hiddenDescription: "hidden description",  
    language: Language.pl  
  ),  
  payer: Payer(  
    name: "John Doe",  
    email: "example@example.com",  
    phone: null,  
    address: null  
  ),  
  callbacks: Callbacks(  
    redirects: Redirects(  
      successUrl: "https://yourstore.com/success",  
      errorUrl: "https://yourstore.com/error",  
    ),  
    notifications: Notifications(  
      url: "https://yourstore.com",  
      email: "payments@yourstore.com"  
    )  
  )  
);  
   
tpay.screenlessCreditCardPayment(payment);
```

> [!warning]
> If CreditCardPayment returns `ScreenlessPaymentCreated` result, you have to handle `paymentUrl`
> sent with it and redirect user to it in order to complete the payment.

#### Tokenization

You can also Opt-in to generate credit card token for future payments
if you want to let user pay for transactions with previously used card.
To do so, in `creditCard -> config` object, set the `shouldSave` to true.

```dart
creditCard: CreditCard(
    cardNumber: "4056 2178 4359 7258",
    expiryDate: ExpirationDate(
        month: "12",
        year: "67"
    ),
    cvv: "123",
    config: CreditCardConfig(
        shouldSave: true,
        domain: "testdomain.com"
    )
),
```

> [!warning]
> Generated card token will be sent to `notificationUrl` specified in the notifications callbacks.

If you already have a credit card token, you can then set up token payment omitting credit card
info.
To do so, use `creditCardToken` instead of `creditCard` field.

```dart
final payment = CreditCardPayment(
  creditCardToken: "card_token",
  paymentDetails: PaymentDetails(  
    amount: 19.99,  
    description: "transaction description",  
    hiddenDescription: "hidden description",  
    language: Language.pl  
  ),  
  payer: Payer(  
    name: "John Doe",  
    email: "example@example.com",  
    phone: null,  
    address: null  
  ),  
  callbacks: Callbacks(  
    redirects: Redirects(  
      successUrl: "https://yourstore.com/success",  
      errorUrl: "https://yourstore.com/error",  
    ),  
    notifications: Notifications(  
      url: "https://yourstore.com",  
      email: "payments@yourstore.com"  
    )  
  )  
);  
   
tpay.screenlessCreditCardPayment(payment);
```

#### Recurring Payments

CreditCardPayment let's you set up the recurring payments as well, so you don't have to remember
to charge your customer for your service periodically.

> [!important]
> You can choose one of the specified recurring payment frequencies:
> `daily`, `weekly`, `monthly`,`quarterly` or `yearly`.

> [!important]
> You can choose to either charge user specified times using quantity (int) option,
> or to set it up to being charged until expiration date is being hit or user cancels subscription
> on his own with `quantity: null`.

```dart
final payment = CreditCardPayment(
  creditCardToken: "card_token", 
  recursive: Recursive(
    frequency: Frequency.monthly,
    quantity: 19,
    endDate: "1410-07-17"
  ),
  paymentDetails: PaymentDetails(  
    amount: 19.99,  
    description: "transaction description",  
    hiddenDescription: "hidden description",  
    language: Language.pl  
  ),  
  payer: Payer(  
    name: "John Doe",  
    email: "example@example.com",  
    phone: null,  
    address: null  
  ),  
  callbacks: Callbacks(  
    redirects: Redirects(  
      successUrl: "https://yourstore.com/success",  
      errorUrl: "https://yourstore.com/error",  
    ),  
    notifications: Notifications(  
      url: "https://yourstore.com",  
      email: "payments@yourstore.com"  
    )  
  )  
);  
   
tpay.screenlessCreditCardPayment(payment);
```

### Screenless BLIK payment
Tpay SDK let's make transactions with BLIK as well. Simply use `BLIKPayment` class.

```dart
final result = BLIKPayment(
  code: "777462",  
  paymentDetails: PaymentDetails(
    amount: 5.21,  
    description: "transaction description",  
    hiddenDescription: "hidden description",  
    language: Language.pl  
  ),  
  payer: Payer(  
    name: "John Doe",  
    email: "john.doe@test.pl",  
    phone: "123456789",  
    address: PayerAddress(
        address: "TEST",
        city: "TEST",
        countryCode: "PL",
        postalCode: "60-111"
    )
  ),  
  callbacks: Callbacks(  
    redirects: Redirects(  
      successUrl: "https://yourstore.com/success",  
      errorUrl: "https://yourstore.com/error",  
    ),  
    notifications: Notifications(  
      url: "https://yourstore.com",  
      email: "payments@yourstore.com"  
    )  
  )  
);  
  
tpay.screenlessBLIKPayment(result);
```

#### BLIK Alias Payment

If you have returning users and you want to make their BLIK payments even smoother,
you can register BLIK Alias for them, so they will only be prompted to accept payment in their
banking app, without need of entering BLIK code each time they want to make the payment.

> [!warning]
> In order to register alias for a user/payment, you have to set `isRegistered` parameter to `false`.

```dart
final result = BLIKPayment(
  code: "777462",  
  alias: BlikAlias(
      isRegistered: false,
      value: "1234",
      label: "alias_1234"
  ),
  // rest of the BLIKPayment configuration
);
```

> [!important]
> Provided alias cannot be assumed as registered until receiving webhook notification about its status. Notification should be received by dedicated backend server, for implementation details check official [documentation](https://docs-api.tpay.com/en/webhooks/) . Additionally your backend server should implement other BLIK related [notifications](https://docs-api.tpay.com/en/webhooks/#blik-one-clickblik-recurring-payments-after-expiration-update-or-delete-alias) to ensure BLIK alias is valid and usable.

Once alias is registered for a user, you can set up `isRegistered` parameter to `true`.

```dart
final result = BLIKPayment(
  alias: BlikAlias(
      isRegistered: true,
      value: "1234",
      label: "alias_1234"
  ),
  // rest of the BLIKPayment configuration
);
```

> [!warning]
> To be able to pay with BLIK alias, you **MUST** set the code parameter to `null`.

> [!warning]
> Before testing BLIK alias functionality check sandbox environment limitations listed in [documentation](https://docs-api.tpay.com/en/first-steps/environments/#blik-payments)

#### BLIK Ambiguous Alias Payment

Sometimes, there is a possibility for one alias to be registered more than once. For example, if
you register alias associated with one user for the multiple banks.
In such a situation, you have to fetch those aliases from Tpay API and show them to the user to let him
choose one for the payment.

In BLIKPayment's call in execute method you can get `ScreenlessBlikAmbiguousAlias`
type of result,
that will indicate that current alias was registered more than once.
This result hold all possible variations of the alias you used to start payment with in `aliases`
field.
You have to simply show them to user, let him choose, and then use chosen alias to retry the
payment.

```dart
if (result is ScreenlessBlikAmbiguousAlias) {
  showAmbiguousAliases(result.aliases);
}
```

> [!warning]
> In such scenario, you have to use different class to make the payment than at the beginning.
> ```dart
> final payment = AmbiguousBLIKPayment(
>   transactionId: "transaction_id",
>   blikAlias: BlikAlias(
>     isRegistered: true,
>     value: "1234",
>     label: "alias_1234",
>   ),
>   ambiguousAlias: AmbiguousAlias(
>     name: chosenAlias.name,
>     code: chosenAlias.code,
>   )
> );
> 
> tpay.screenlessAmbiguousBLIKPayment(payment);
> ```

> [!important]
> Right now, Tpay SDK does NOT support recurring payments with BLIK
> In order to achieve that, check
> our [API support for BLIK recurring payments](https://docs-api.tpay.com/en/payment-methods/blik/#blik-recurring-payments).

### Screenless Transfer Payment

Tpay SDK allows you to make transfer payments with bank available to your merchant account.

> [!tip]
> To get banks with their channel ids check
> the [Get Payment Channels](https://docs-api.tpay.com/en/first-steps/list-of-payment-methods/)
> section.

After your customer chooses their bank from the list, you can use it's `channelId` to make the payment.

```dart
final payment = TransferPayment(  
  channelId: 4,
  bankName: "bank_name",
  paymentDetails: PaymentDetails(  
    amount: 19.99,  
    description: "transaction description",  
    hiddenDescription: "hidden description",  
    language: Language.pl  
  ),  
  payer: Payer(  
    name: "John Doe",  
    email: "example@example.com",  
    phone: null,  
    address: null  
  ),  
  callbacks: Callbacks(  
    redirects: Redirects(  
      successUrl: "https://yourstore.com/success",  
      errorUrl: "https://yourstore.com/error",  
    ),  
    notifications: Notifications(  
      url: "https://yourstore.com",  
      email: "payments@yourstore.com"  
    )  
  )  
);  
  
tpay.screenlessTransferPayment(payment);
```

> [!warning]
> If TransferPayment returns `ScreenlessPaymentCreated` result, you have to handle `paymentUrl`
> sent with it and redirect user to it in order to complete the payment.

### Screenless Installment Payments

Tpay SDK allows you to create long term installment payments.

```dart
final payment = RatyPekaoPayment(
  channelId: 81,
  paymentDetails: PaymentDetails(
    amount: 119.99,
    description: "transaction description",
    hiddenDescription: "hidden description",
    language: Language.pl
  ),
  payer: Payer(
    name: "John Doe",
    email: "example@example.com",
    phone: null,
    address: null
  ),
  callbacks: Callbacks(
    redirects: Redirects(
      successUrl: "https://yourstore.com/success",
      errorUrl: "https://yourstore.com/error",
    ),
    notifications: Notifications(
      url: "https://yourstore.com",
      email: "payments@yourstore.com"
    )
  ),
);

tpay.screenlessRatyPekaoPayment(payment);
```

> [!warning]
> If RatyPekaoPayment returns `ScreenlessPaymentCreated` result, you have to handle `paymentUrl`
> sent with it and redirect user to it in order to complete the payment.

### Screenless Deferred Payments

Tpay SDK allows you to create deferred payments (BNPL) using PayPo method.

> [!warning]
> For PayPo payment to work, amount of the payment must be at least 40PLN!
> For more information about PayPo payments
> check [our PayPo documentation](https://docs-api.tpay.com/en/payment-methods/bnpl/#paypo).

> [!tip]
> For sandbox, working phone number is `500123456`

```dart
final payment = PayPoPayment(
  paymentDetails: PaymentDetails(
    amount: 119.99,
    description: "transaction description",
    hiddenDescription: "hidden description",
    language: Language.pl
  ),
  payer: Payer(
    name: "John Doe",
    email: "example@example.com",
    phone: null,
    address: null
  ),
  callbacks: Callbacks(
    redirects: Redirects(
      successUrl: "https://yourstore.com/success",
      errorUrl: "https://yourstore.com/error",
    ),
    notifications: Notifications(
      url: "https://yourstore.com",
      email: "payments@yourstore.com"
    )
  ),
);

tpay.screenlessPayPoPayment(payment);
```

> [!warning]
> If PayPoPayment returns `ScreenlessPaymentCreated` result, you have to handle `paymentUrl`
> sent with it and redirect user to it in order to complete the payment.

### Screenless Google Pay Payment

Tpay SDK allows you to perform Google Pay transactions.

```dart
final payment = GooglePayPayment(
  token: "google_pay_token",
  paymentDetails: PaymentDetails(
    amount: 19.99,
    description: "transaction description",
    hiddenDescription: "hidden description",
    language: Language.pl
  ),
  payer: Payer(
      name: "John Doe",
      email: "example@example.com",
      phone: null,
      address: null
  ),
  callbacks: Callbacks(
    redirects: Redirects(
      successUrl: "https://yourstore.com/success",
      errorUrl: "https://yourstore.com/error",
    ),
    notifications: Notifications(
      url: "https://yourstore.com",
      email: "payments@yourstore.com"
    )
 )
);

tpay.screenlessGooglePayPayment(payment);
```

> [!warning]
> If GooglePayPayment returns `Created` result, you have to handle `paymentUrl`
> sent with it and redirect user to it in order to complete the payment.

> [!warning]
> Take under consideration, that choosing this option,
> you have to configure whole Google Wallet SDK and fetch Google Pay token on your own.
> For `ANDROID` system only, we provide a bit smoother way of handling Google Pay transactions with our wrappers.

#### Google Pay Utils

If you do not want to configure whole Google Pay functionality, you can use `GooglePlayUtil` class.
It will handle all payments, with additional info in the bottom sheet and send you all the needed info in
callback.

> [!important]
> To use GooglePayUtil, first, you have to configure them it.

```dart
final configuration = GooglePayUtilsConfiguration(
  price: 39.99,
  merchantName: "merchant_name",
  merchantId: "merchant_id",
  environment: GooglePayEnvironment.test,
);

final configurationResult = tpay.configureGooglePayUtils(configuration);

switch (configurationResult) {
  case GooglePayConfigureSuccess():
    break;
  case GooglePayConfigureError():
    break;
}
```

> [!warning]
> Before you use our utils, make sure Google Pay is enabled in the device. Use `isGooglePayAvailable` method.

```dart
final isAvailable = await _tpay.isGooglePayAvailable();

if (isAvailable) {
  // display Google Pay button
}
```

Next, you can open Google Pay module and let user choose his credit card, so you can use it to make
the payment.

```dart
final googlePayResult = await _tpay.openGooglePay();

switch (googlePayResult) {
  case GooglePayOpenSuccess():
    break;
  case GooglePayOpenCancelled():
    break;
  case GooglePayOpenUnknownError():
    break;
  case GooglePayOpenNotConfigured():
    break;
}
```

> [!important]
> If `googlePayResult` returns `GooglePayOpenSuccess`, you **HAVE TO** use it's content to make an actual
> payment buy using `GooglePayPayment` and `screenlessGooglePayPayment`.

`merchant_id` is unique identifier assigned to you during Tpay account registration.

> [!warning]
> In order to launch Google Pay on production follow [these guidelines](#production-readiness)

### Screenless Apple Pay payment

Tpay SDK allows you to perform Apple Pay transactions.

> [!warning]
> Apple Pay is available exclusively on Apple devices (iPhone, iPad, MacBook, iMac) and supports only **Visa** and **Mastercard**.

> [!warning]
> To be able to complete Apple Pay payment, you will need `apple_pay_token`. You **HAVE TO**
> acquire a token by yourself using Apple's PassKit framework. To do that check
> official [Apple Pay documentation](https://developer.apple.com/documentation/passkit/apple_pay/setting_up_apple_pay)

```dart
final payment = ApplePayPayment(
  applePayToken: "apple_pay_token",
  paymentDetails: PaymentDetails(
    amount: 19.99,
    description: "transaction description",
    hiddenDescription: "hidden description",
    language: Language.pl
  ),
  payer: Payer(
    name: "John Doe",
    email: "example@example.com",
    phone: null,
    address: null
  ),
  callbacks: Callbacks(
    redirects: Redirects(
      successUrl: "https://yourstore.com/success",
      errorUrl: "https://yourstore.com/error",
    ),
    notifications: Notifications(
      url: "https://yourstore.com",
      email: "payments@yourstore.com"
    )
  )
);

tpay.screenlessApplePayPayment(payment);
```

## License

This library is released under the [MIT License](https://opensource.org/license/mit/).
