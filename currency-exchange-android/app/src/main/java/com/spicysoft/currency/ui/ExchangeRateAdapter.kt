package com.spicysoft.currency.ui

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.spicysoft.currency.BR
import com.spicysoft.currency.R
import com.spicysoft.currency.model.dto.ExchangeRate

class ExchangeRateAdapter: ListAdapter<ExchangeRate, ExchangeRateAdapter.ExchangeRateViewHolder>(
    DIFF_UTIL) {

    companion object {
        private val DIFF_UTIL = object : DiffUtil.ItemCallback<ExchangeRate>() {

            override fun areItemsTheSame(oldItem: ExchangeRate, newItem: ExchangeRate): Boolean {
                return oldItem.shortName == newItem.shortName
            }

            override fun areContentsTheSame(oldItem: ExchangeRate, newItem: ExchangeRate): Boolean {
                return oldItem == newItem
            }

        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ExchangeRateViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = DataBindingUtil.inflate<ViewDataBinding>(inflater, R.layout.layout_currency_rate, parent, false)
        return ExchangeRateViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ExchangeRateViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    class ExchangeRateViewHolder(
        private val binding: ViewDataBinding
    ): RecyclerView.ViewHolder(binding.root) {

        fun bind(rate: ExchangeRate) {
            binding.setVariable(BR.rate, rate)
        }

    }

}