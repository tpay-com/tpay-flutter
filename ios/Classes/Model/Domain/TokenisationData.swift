//
//  TokenisationData.swift
//  flutter_tpay
//
//  Created by Karol Kaluga on 26/03/2024.
//

import Foundation
import Tpay

struct TokenizationData{
    let payer: Payer
    let notificationUrl: String
    let successRedirectUrl: String?
    let errorRedirectUrl: String?
}
