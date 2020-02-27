//
//  CurrenciesData.swift
//  CurrencyExchange
//
//  Created by Phyo Htet Arkar on 2/10/20.
//  Copyright © 2020 Phyo Htet Arkar. All rights reserved.
//

import Foundation
import Combine
import Alamofire

final class CurrenciesData: ObservableObject {
    
    private static let API_URL = "https://forex.cbm.gov.mm/api/latest"
    private static let excepts = ["JPY", "KHR", "IDR", "KRW", "LAK", "VND"]
    
    private let dateFormatter = DateFormatter()
    
    @Published var loading = false
    @Published var error = false
    @Published var searchText = ""
    @Published var lastUpdated = ""
    @Published var rates = [ExchangeRate]()
    
    init() {
        findLatestExchangeRates()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm a"
    }
    
    func findLatestExchangeRates() {
        loading = true
        
        AF.request(CurrenciesData.API_URL).responseString { [weak self] resp in
            self?.loading = false
            
            switch resp.result {
            case .success(let value):
                do {
                    let json = value as String
                    let result = try JSONDecoder().decode(ExchangeData.self, from: json.data(using: .utf8)!)
                    
                    let mirror = Mirror(reflecting: result.rates)
                    var list = [ExchangeRate]()
                    
                    for attr in mirror.children {
                        if let short = attr.label, let name = currencies[short] {
                            
                            var amt = attr.value as! String
                            
                            if CurrenciesData.excepts.contains(short) {
                                amt = String(format: "%.3f", (Double(amt.replacingOccurrences(of: ",", with: "")) ?? 0.0) / 100)
                            }
                            
                            let rate = ExchangeRate(short: short, name: name, amount: amt)
                            list.append(rate)
                            
                        }
                    }
                    
                    if let unixTimestamp = Double(result.timestamp) {
                        let date = Date(timeIntervalSince1970: unixTimestamp)
                        self?.lastUpdated = self?.dateFormatter.string(from: date) ?? ""
                    }                    
                    
                    self?.error = false
                    self?.rates = list
                } catch {
                    self?.error = true
                    //print("Error decoding job positions \(decodeError)")
                    print(error.localizedDescription)
                }
            case .failure(let error):
                self?.error = true
                print(error.localizedDescription)
            }
        }
    }
}
