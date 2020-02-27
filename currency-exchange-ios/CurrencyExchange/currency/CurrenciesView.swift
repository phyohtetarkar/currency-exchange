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
        //UITableViewHeaderFooterView.appearance().tintColor = UIColor.white
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                List {
                    SearchTextView(filter: $data.searchText)
                    
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
                    
//                    CurrencyRow(rate: ExchangeRate(short: "EUR", name: "Euro", amount: "1,591.4"))
//                    CurrencyRow(rate: ExchangeRate(short: "USD", name: "United State Dollar", amount: "1451.6"))
//                    CurrencyRow(rate: ExchangeRate(short: "THB", name: "Thai Baht", amount: "46.466"))
                }
                .navigationBarTitle("Exchange Rates")
                .navigationBarItems(trailing: Button(action: {
                    self.data.findLatestExchangeRates()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.headline)
                }))
                .alert(isPresented: $data.error, content: {
                        Alert(title: Text("Error"), message: Text("Network error."), dismissButton: Alert.Button.cancel())
                })
                
                Divider()
                
                HStack(alignment: .center) {
                    Text("Last Updated")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text(data.lastUpdated)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }.padding()
                
            }
        }
    }
}

struct SearchTextView: View {
    
    @Binding var filter: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            TextField("Search", text: $filter)
        }
        .padding(8)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

struct CurrencyRow: View {
    
    var rate: ExchangeRate
    
    var body: some View {
        VStack {
            HStack {
                Image("flags/\(rate.short)")
                    .resizable()
                    .frame(width: 80, height: 50)
                    .cornerRadius(3)
                    .shadow(radius: 3)
                
                VStack(alignment: .leading) {
                    Text(rate.short)
                        .font(.headline)
                    Text(rate.name)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text("\(rate.amount) MMK").font(.system(size: 14))
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            //.colorScheme(.dark)
            //.background(Color.blue)
            //.cornerRadius(5)

            Divider()
        }
    }
}

#if DEBUG
struct CurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyList().environmentObject(CurrenciesData())
        //CurrencyRow(rate: ExchangeRate(short: "EUR", name: "Euro", amount: "1,591.4"))
    }
}
#endif
