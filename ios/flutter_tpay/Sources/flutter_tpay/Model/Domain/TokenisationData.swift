import Foundation
import Tpay

struct TokenizationData{
    let payer: Payer
    let notificationUrl: String
    let successRedirectUrl: String?
    let errorRedirectUrl: String?
}
