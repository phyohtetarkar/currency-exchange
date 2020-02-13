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
    
    private let API_URL = "https://forex.cbm.gov.mm/api/latest"
    
    @Published var loading = false
    @Published var searchText = ""
    @Published var rates = [ExchangeRate]()
    
    init() {
        findLatestExchangeRates()
    }
    
    func findLatestExchangeRates() {
        loading = true
        
        AF.request(API_URL).responseString { [weak self] resp in
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
                            let rate = ExchangeRate(short: short, name: name, amount: attr.value as! String)
                            
                            list.append(rate)
                        }
                    }
                    self?.rates = list
                } catch {
                    //print("Error decoding job positions \(decodeError)")
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
