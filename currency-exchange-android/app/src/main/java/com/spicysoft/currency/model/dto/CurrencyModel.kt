package com.spicysoft.currency.model.dto

import com.fasterxml.jackson.annotation.JsonProperty
import org.joda.time.DateTime
import java.text.DecimalFormat

data class ExchangeData(
    val updatedTime: DateTime,
    val rates: List<ExchangeRate>
)

data class ExchangeRate(
    val shortName: String,
    val desc: String,
    val rate: String
) {
    val _rate: String
        get() = when (shortName) {
            in "JPY", "KHR", "IDR", "KRW", "LAK", "VND" -> {
                val df = DecimalFormat("#,###.###")
                df.format(rate.replace(",", "").toDouble().div(100))
            }
            else -> rate
        }
}

class CurrencyData {
    val info: String = ""
    val description: String = ""
    val timestamp: String = ""
    val rates = CurrencyRates()
}

class DescriptionData {
    val info: String = ""
    val description: String = ""
    val currencies = CurrencyRates()
}

class CurrencyRates {
    @JsonProperty("USD") var USD = ""
    @JsonProperty("THB") var THB = ""
    @JsonProperty("CAD") var CAD = ""
    @JsonProperty("PKR") var PKR = ""
    @JsonProperty("GBP") var GBP = ""
    @JsonProperty("KES") var KES = ""
    @JsonProperty("SAR") var SAR = ""
    @JsonProperty("AUD") var AUD = ""
    @JsonProperty("LAK") var LAK = ""
    @JsonProperty("DKK") var DKK = ""
    @JsonProperty("INR") var INR = ""
    @JsonProperty("LKR") var LKR = ""
    @JsonProperty("BND") var BND = ""
    @JsonProperty("NZD") var NZD = ""
    @JsonProperty("EUR") var EUR = ""
    @JsonProperty("VND") var VND = ""
    @JsonProperty("CNY") var CNY = ""
    @JsonProperty("PHP") var PHP = ""
    @JsonProperty("CHF") var CHF = ""
    @JsonProperty("KRW") var KRW = ""
    @JsonProperty("EGP") var EGP = ""
    @JsonProperty("RSD") var RSD = ""
    @JsonProperty("BDT") var BDT = ""
    @JsonProperty("MYR") var MYR = ""
    @JsonProperty("IDR") var IDR = ""
    @JsonProperty("SEK") var SEK = ""
    @JsonProperty("KHR") var KHR = ""
    @JsonProperty("NOK") var NOK = ""
    @JsonProperty("SGD") var SGD = ""
    @JsonProperty("ILS") var ILS = ""
    @JsonProperty("JPY") var JPY = ""
    @JsonProperty("KWD") var KWD = ""
    @JsonProperty("CZK") var CZK = ""
    @JsonProperty("RUB") var RUB = ""
    @JsonProperty("HKD") var HKD = ""
    @JsonProperty("ZAR") var ZAR = ""
    @JsonProperty("BRL") var BRL = ""
    @JsonProperty("NPR") var NPR = ""
}