//
//  CurrenciesView.swift
//  CurrencyExchange
//
//  Created by Phyo Htet Arkar on 2/10/20.
//  Copyright © 2020 Phyo Htet Arkar. All rights reserved.
//

import SwiftUI

struct CurrencyList: View {
    
    @EnvironmentObject var data: CurrenciesData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List {
                TextField("Search...", text: $data.searchText)
                    .padding(8)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)

                if data.loading {
                    HStack {
                        Spacer()
                        ActivityIndicator(shouldAnimate: $data.loading).colorScheme(colorScheme)
                        Spacer()
                    }
                }

                ForEach(data.rates) { rate in
                    if self.data.searchText.isEmpty || rate.short.lowercased().starts(with: self.data.searchText.lowercased()) {
                        CurrencyRow(rate: rate)
                    }
                }
                
//                CurrencyRow(rate: ExchangeRate(short: "EUR", name: "Euro", amount: "1,591.4"))
//                CurrencyRow(rate: ExchangeRate(short: "USD", name: "United State Dollar", amount: "1451.6"))
//                CurrencyRow(rate: ExchangeRate(short: "THB", name: "Thai Baht", amount: "46.466"))
            }
            .navigationBarTitle("Currencies")
            .navigationBarItems(trailing: Button(action: {
                self.data.findLatestExchangeRates()
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .font(.headline)
            }))
        }
    }
}

struct CurrencyRow: View {
    
    var rate: ExchangeRate
    
    var body: some View {
        HStack {
            Image("flags/\(rate.short)")
                .resizable()
                .frame(width: 80, height: 50)
            
            VStack(alignment: .leading) {
                Text(rate.short)
                    .font(.headline)
                Text(rate.name)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text("\(rate.amount) MMK").font(.system(size: 14))
        }
        .colorScheme(.dark)
        .padding(12)
        .background(Color.blue)
        .cornerRadius(5)
    }
}

struct CurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyList()
    }
}
