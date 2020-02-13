//
//  Currency.swift
//  CurrencyExchange
//
//  Created by Phyo Htet Arkar on 2/10/20.
//  Copyright © 2020 Phyo Htet Arkar. All rights reserved.
//

import Foundation

struct ExchangeRate: Identifiable {
    var id = UUID()
    var short: String
    var name: String
    var amount: String
}

struct ExchangeData: Decodable {
    let info: String
    let description: String
    let timestamp: String
    let rates: Rates
}

struct Rates: Decodable {
    var USD: String
    var PHP: String
    var KRW: String
    var VND: String
    var HKD: String
    var BRL: String
    var RSD: String
    var MYR: String
    var CAD: String
    var GBP: String
    var SEK: String
    var NOK: String
    var ILS: String
    var DKK: String
    var AUD: String
    var RUB: String
    var KWD: String
    var INR: String
    var BND: String
    var EUR: String
    var ZAR: String
    var NPR: String
    var CNY: String
    var CHF: String
    var KES: String
    var THB: String
    var PKR: String
    var EGP: String
    var BDT: String
    var SAR: String
    var LAK: String
    var SGD: String
    var IDR: String
    var KHR: String
    var LKR: String
    var NZD: String
    var CZK: String
    var JPY: String
}

let currencies = [
    "USD": "United State Dollar",
    "EUR": "Euro",
    "SGD": "Singapore Dollar",
    "GBP": "Pound Sterling",
    "CHF": "Swiss Franc",
    "JPY": "Japanese Yen",
    "AUD": "Australian Dollar",
    "BDT": "Bangladesh Taka",
    "BND": "Brunei Dollar",
    "KHR": "Cambodian Riel",
    "CAD": "Canadian Dollar",
    "CNY": "Chinese Yuan",
    "HKD": "Hong Kong Dollar",
    "INR": "Indian Rupee",
    "IDR": "Indonesian Rupiah",
    "KRW": "Korean Won",
    "LAK": "Lao Kip",
    "MYR": "Malaysian Ringgit",
    "NZD": "New Zealand Dollar",
    "PKR": "Pakistani Rupee",
    "PHP": "Philippines Peso",
    "LKR": "Sri Lankan Rupee",
    "THB": "Thai Baht",
    "VND": "Vietnamese Dong",
    "BRL": "Brazilian Real",
    "CZK": "Czech Koruna",
    "DKK": "Danish Krone",
    "EGP": "Egyptian Pound",
    "ILS": "Israeli Shekel",
    "KES": "Kenya Shilling",
    "KWD": "Kuwaiti Dinar",
    "NPR": "Nepalese Rupee",
    "NOK": "Norwegian Kroner",
    "RUB": "Russian Rouble",
    "SAR": "Saudi Arabian Riyal",
    "RSD": "Serbian Dinar",
    "ZAR": "South Africa Rand",
    "SEK": "Swedish Krona"
]
