# Tpay
[![Min Android SDK](https://img.shields.io/badge/Min%20sdk-23-informational.svg)](https://shields.io/)[![Target Android SDK](https://img.shields.io/badge/Target/Compile%20sdk-33-informational.svg)](https://shields.io/)

## About
This plugin allows your app to make payments with Tpay.

# Usage

## Get Tpay instance
```dart
final TpayPlatform tpay = TpayPlatform.instance;
```

## UI Module
Tpay plugin contains UI module. Users can interact with it to make payments.

### Setup
#### Android
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
#### IOS

When integrating the Tpay payment module into your app, it’s important to ensure that the necessary permissions are correctly set up to ensure a smooth user experience.

##### Privacy - Camera Usage Description

The module allows the user to automatically fill the credit card form for secure payment processing. This feature requires you to setup the “Privacy - Camera Usage Description” in your app’s Info.plist file.

Integration Steps
1. Open your project’s Info.plist file.
2. Add the key-value pair for the “Privacy - Camera Usage Description” permission, explaining the purpose of camera access. Clearly state that the camera is used to facilitate the automatic filling of the credit card form for secure payment processing.

Example:
```
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to automatically fill the credit card form for secure payment processing.</string>
```
### Configure Tpay module
This configuration allows your app to use Tpay UI module and screenless payments.
```dart
final configuration = TpayConfiguration(  
  merchant: Merchant(
    authorization: MerchantAuthorization(
      clientId: "YOUR_CLIENT_ID", 
      clientSecret: "YOUR_CLIENT_SECRET"
    ),
    environment: TpayEnvironment.production,
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
      LocalizedString(language: Language.pl, value: "polish regulation url"),  
      LocalizedString(language: Language.en, value: "english regulation url")  
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
    installmentPayments: [InstallmentPayment.ratyPekao, InstallmentPayment.payPo]
  ),
);  

tpay.configure(configuration);
```

### Payment with Tpay UI
```dart
final transaction = SingleTransaction(  
  amount: 19.99,  
  description: "transaction description",  
  payerContext: PayerContext(  
    payer: Payer(  
      name: "John Doe",  
      email: "example@example.com",  
      phone: null,  
      address: null  
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
  )  
);  

tpay.startPayment(
  transaction,
  onPaymentCreated: (transactionId) {
    // The onPaymentCreated optional parameter is a callback function
    // that is triggered when a payment is successfully created.
    // It could receives the transactionId as an argument, allowing you to handle the event.
  },
);
```

### Credit card tokenization
```dart
final payer = Payer(  
  name: "John Doe",  
  email: "example@example.com",  
  phone: null,  
  address: null  
);  

tpay.tokenizeCard(Tokenization(payer: payer, notificationUrl: "https://yourstore.com/notifications"));
```

### Credit card token payment
```dart
final tokenPayment = TokenPayment(  
  amount: 19.99,  
  description: "transaction description",  
  cardToken: "card token",  
  payer: Payer(  
    name: "John Doe",  
    email: "example@example.com",  
    phone: null,  
    address: null  
  ),  
);  

tpay.startCardTokenPayment(tokenPayment);
```
### Tpay UI module result handling
```dart
void handleResult(Result result){  
  if (result is PaymentCompleted) {  
    // payment completed successfully and Tpay module was closed  
  }  
  if (result is PaymentCancelled) {  
    // payment failed and Tpay module was closed  
  }  
  if (result is TokenizationCompleted) {  
    // tokenization was successful and Tpay module was closed  
  }  
  if (result is TokenizationFailure) {  
    // tokenization failed and Tpay module was closed  
  }  
  if (result is ConfigurationSuccess) {  
    // Tpay module configuration was successful  
  }  
  if (result is ValidationError) {  
    // passed data is incorrect  
  }  
  if (result is ModuleClosed) {  
    // user closed the Tpay module  
    // without making a payment or tokenization
  }
  if (result is MethodCallError) {  
    // something went wrong with the plugin  
  }  
}
```

## Screenless payments
Tpay plugin allows for creating payments without displaying the Tpay UI module.

### Screenless BLIK payment
User can pay with 6 digit BLIK code or alias (returning users only).
```dart
final payment = BLIKPayment(
  code: "123456",  
  alias: BlikAlias(isRegistered: true, value: "alias value", label: "label"),  
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
  
tpay.screenlessBLIKPayment(payment);
```
### Screenless Ambiguous BLIK payment
screenlessBLIKPayment(...) method can return a ScreenlessBlikAmbiguousAlias result, 
this means that user has BLIK alias registered in more than one bank.
You need to display ambiguous aliases provided in ScreenlessBlikAmbiguousAlias result to the user.
After that, you need to continue the payment with ambiguous alias selected by user using screenlessAmbiguousBLIKPayment(...) method.
```dart
final payment = AmbiguousBLIKPayment(
  transactionId: "id", // received from ScreenlessBlikAmbiguousAlias result
  blikAlias: BlikAlias(...), // BLIK alias used to create payment with screenlessBLIKPayment(...) method
  ambiguousAlias: AmbiguousAlias(...) // ambiguous alias selected by user
);

tpay.screenlessAmbiguousBLIKPayment(payment);
```
### Screenless transfer payment
Transfer payment requires a channelId of bank in Tpay system.
```dart
final payment = TransferPayment(  
  channelId: 4,  
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
### Screenless Raty Pekao payment
Raty Pekao payment requires a channelId of Raty Pekao variant.
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

### Screenless PayPo payment
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

### Screenless credit card payment
User can pay with credit card or credit card token (returning users only). When paying with card number, expiration date and cvv user should have a option to save card. If selected, after a successful payment the card token will be sent to notification url if defined.
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
  creditCardToken: "card token",  
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
### Screenless Google Pay payment
Users can pay with Google Pay, in order to start the payment you need to provide the Google Pay token. 
To make this process easier you can use Google Pay utils described later in this document.
```dart
final payment = GooglePayPayment(
  token: "google pay token",
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
### Screenless Apple Pay payment
Users can pay with Apple Pay, in order to start the payment you need to provide the Apple Pay token.
```dart
final payment = ApplePayPayment(
  applePayToken: "apple pay token",
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
### Screenless payment result handling
```dart
void handleScreenlessResult(ScreenlessResult result) {  
  if (result is ScreenlessPaid) {  
    // payment completed successfully  
  }  
  if (result is ScreenlessPaymentCreated) {  
    // payment was successfully created  
    // if it was a BLIK payment user has to accept it in bank app    
    // if it was a credit card or transfer payment you have to    
    // display result.paymentUrl to finish the payment    
    // it is advised to use long polling mechanism to observe    
    // payment status    
    // you can get transaction id from result.transactionId    
  }
  if (result is ScreenlessPaymentError) {  
    // creating payment failed  
  }  
  if (result is ScreenlessConfiguredPaymentFailed) {  
    // creating payment failed because of error with:  
    // - credit card data or credit card token    
    // - BLIK code or BLIK alias  
  }
  if (result is ScreenlessBlikAmbiguousAlias) {
    // when using BLIK payment with alias this result indicates
    // that user has alias registered in more than one bank
    
    // display result.aliases to the user and
    // continue payment using tpay.screenlessAmbiguousBLIKPayment(...) method
  }
  if (result is ScreenlessValidationError) {  
    // passed data is incorrect  
  }  
  if (result is ScreenlessMethodCallError) {  
    // something went wrong with the plugin  
  }  
}
```
## Google Pay utils (Android only)
SDK offers few convenience methods of interacting with Google Pay.
```dart
// Configure Google Pay utils before using other methods
final configuration = GooglePayUtilsConfiguration(
  price: 39.99, // final price
  merchantName: "YOUR_STORE_NAME",
  merchantId: "MERCHANT_ID",
  environment: GooglePayEnvironment.production
);

final configurationResult = await tpay.configureGooglePayUtils(configuration);
if (configurationResult is GooglePayConfigureSuccess) {
  // configuration successful
}

if (configurationResult is GooglePayConfigureError) {
  // configuration failed
  // check error message via configurationResult.message
}

// Check if Google Pay is available
// This method will always return false if Google Pay utils are not configured
final isAvailable = await tpay.isGooglePayAvailable();
if (isAvailable) {
  // display Google Pay button
}

// If Google Pay is available, you can open it
final googlePayResult = await tpay.openGooglePay();

if (googlePayResult is GooglePayOpenSuccess) {
  // credit card data was received successfully
  // this result contains token, description, cardNetwork and cardTail parameters
  // use googlePayResult.token parameter with tpay.screenlessGooglePayPayment(...) 
  // to create a Google Pay payment
}

if (googlePayResult is GooglePayOpenCancelled) {
  // user closed the Google Pay module without selecting a credit card
}

if (googlePayResult is GooglePayOpenUnknownError) {
  // unknown error
}

if (googlePayResult is GooglePayOpenNotConfigured) {
  // Google Pay utils not configured
}
```
## Fetch payment channels
Fetch available payment channels for your merchant account. Filter channels based on payment constraints.
```dart
final result = await tpay.getAvailablePaymentChannels();

if (result is PaymentChannelsSuccess) {
  // payment channels received
  for (var channel in result.channels) {
    // channel can have payment constraints
    // that need to be satisfied, otherwise the payment creation will fail
    for (var constraint in channel.constraints) {
      if (constraint is AmountPaymentConstraint) {
        // check if your payment amount is between
        // - constraint.minimum
        // - constraint.maximum
        // this constraint can have:
        // - only minimum value
        // - only maximum value
        // - minimum and maximum values
      }
    }
    
    // display payment channel if all payment constraints are satisfied
  }
}
if (result is PaymentChannelsError) {
  // error occurred
  // read error message via result.message
}
```

## Run sample application
```bash
git clone <github-link> tpay
cd tpay/example
flutter run
```
