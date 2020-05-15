//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Phyo Htet Arkar on 2/10/20.
//  Copyright © 2020 Phyo Htet Arkar. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    
    var body: some View {
        AboutContent()
            .navigationBarTitle("About", displayMode: .inline)
       
    }
}

struct AboutContent: View {
    
    let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("AppImage")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            Text("Exchange Rates Of Myanmar")
                .font(.system(size: 20))
                .bold()
                .multilineTextAlignment(.center)
                .opacity(0.8)
            
            Text("Created by Phyo Htet Arkar")
                .opacity(0.8)
            
            Spacer()
            
            Text("Version \(nsObject as! String)")
                .font(.system(size: 15))
                .opacity(0.8)
            
            Text("Credit API: http://forex.cbm.gov.mm/api")
                .font(.system(size: 15))
                .opacity(0.8)
        }.padding()
    }
}

#if DEBUG
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
#endif
