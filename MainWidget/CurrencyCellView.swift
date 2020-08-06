//
//  CurrencyCellView.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 06.08.2020.
//

import SwiftUI

struct CurrencyCellView: View {
    let exchangeRate: Double
    let previousExchangeRate: Double
    let countryISO: String
    let currencyISO: String
        
    var body: some View {
        HStack {
            Image(self.countryISO + "_circled")
                .resizable()
                .frame(width: 32.0, height: 32.0)
            Spacer()
            Text(self.currencyISO)
                .foregroundColor(.white)
                .font(.headline)
            Spacer()
            Text("\(String(format: "%.2f", exchangeRate)) ₽")
                .foregroundColor(.white)
                .font(.title2)
            
            if previousExchangeRate == exchangeRate {
                Image("equal")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 10)
            } else if (previousExchangeRate - exchangeRate < 0) {
                Image("growUp")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 10)
            } else {
                Image("goDown")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 10)
            }
            
        }.padding(.horizontal, 10)
    }
}

struct CurrencyCellViewPreviews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            let colors = Gradient(colors: [.purple, .blue])
            let conic = LinearGradient(
                gradient: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Rectangle().fill(conic)
            
            CurrencyCellView(
                exchangeRate: 0.0,
                previousExchangeRate: 0.0,
                countryISO: "UK",
                currencyISO: "GBP"
            )
        }
        
    }
}
