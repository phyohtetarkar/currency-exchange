//
//  ActivityIndicator.swift
//  CurrencyExchange
//
//  Created by Phyo Htet Arkar on 2/11/20.
//  Copyright © 2020 Phyo Htet Arkar. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
}
