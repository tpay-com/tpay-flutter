enum BridgeMethod: String {

    case configureMerchant = "configure"
    case singleTransactionPayment = "startPayment"
    case cardTokenTransaction = "startCardTokenPayment"
    case addCard = "tokenizeCard"
    case paymentWithCard = "screenlessCreditCardPayment"
    case paymentWithBlik = "screenlessBLIKPayment"
    case paymentWithBank = "screenlessTransferPayment"
    case paymentWithPayPo = "screenlessPayPoPayment"
    case paymentWithApplePay
    case continuePayment = "screenlessAmbiguousBLIKPayment"
    case getPaymentMethods = "getPaymentChannels"
}
