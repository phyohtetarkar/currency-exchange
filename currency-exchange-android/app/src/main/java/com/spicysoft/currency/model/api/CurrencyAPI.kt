package com.spicysoft.currency.model.api

import com.spicysoft.currency.model.dto.CurrencyData
import com.spicysoft.currency.model.dto.DescriptionData
import io.reactivex.Observable
import retrofit2.http.GET

interface CurrencyAPI {

    @GET("latest")
    fun getCurrencies(): Observable<CurrencyData>

    @GET("currencies")
    fun getDescriptions(): Observable<DescriptionData>

}