package com.spicysoft.currency.model.service

import com.spicysoft.currency.model.api.CurrencyAPI
import com.spicysoft.currency.model.dto.CurrencyRates
import com.spicysoft.currency.model.dto.ExchangeData
import com.spicysoft.currency.model.dto.ExchangeRate
import io.reactivex.Observable
import org.joda.time.DateTime

class CurrencyService(private val api: CurrencyAPI) {

    fun getCurrencyRates(): Observable<ExchangeData> {
        return api.getCurrencies().map {
            val dateTime = DateTime(it.timestamp.toLong() * 1000)

            val ratesImp = mutableListOf<ExchangeRate>()
            val rates = mutableListOf<ExchangeRate>()

            val desc = api.getDescriptions().blockingFirst()

            for (f in CurrencyRates::class.java.declaredFields) {
                f.isAccessible = true
                val rate = ExchangeRate(f.name, f.get(desc.currencies) as String, f.get(it.rates) as String)

                when (f.name) {
                    in "USD", "EUR", "SGD", "THB", "MYR", "GBP" -> {
                        ratesImp.add(rate)
                    }

                    else -> rates.add(rate)
                }

            }

            ratesImp.addAll(rates)

            return@map ExchangeData(dateTime, ratesImp)
        }
    }

}