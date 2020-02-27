package com.spicysoft.currency.ui

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.spicysoft.currency.model.ResponseStatus
import com.spicysoft.currency.model.RetrofitManager
import com.spicysoft.currency.model.api.CurrencyAPI
import com.spicysoft.currency.model.dto.ExchangeRate
import com.spicysoft.currency.model.service.CurrencyService
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import org.joda.time.DateTime
import java.util.*

class CurrencyListViewModel(application: Application) : AndroidViewModel(application) {

    private val service: CurrencyService

    private val compositeDisposable = CompositeDisposable()

    private var _rates: List<ExchangeRate>? = null

    val updatedTime = MutableLiveData<DateTime>()
    val rates = MutableLiveData<List<ExchangeRate>>()
    val responseStatus = MutableLiveData<ResponseStatus>()

    init {
        service = CurrencyService(RetrofitManager.create(CurrencyAPI::class.java))
    }

    fun loadCurrencyRates() {
        val disposable = service.getCurrencyRates()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                updatedTime.value = it.updatedTime
                rates.value = it.rates
                _rates = it.rates
                responseStatus.value = ResponseStatus.SUCCESS
            }, {
                Log.e("TAG", it.message ?: "Something went wrong.")
                responseStatus.value = ResponseStatus.ERROR
            })

        compositeDisposable.add(disposable)
    }

    fun filterCurrencyRates(value: String) {
        _rates?.also {
            rates.value = it.filter { rate ->
                rate.shortName.toLowerCase(Locale.ENGLISH).startsWith(value.toLowerCase(
                Locale.ENGLISH))
            }
        }
    }

    override fun onCleared() {
        super.onCleared()
        compositeDisposable.dispose()
    }

}