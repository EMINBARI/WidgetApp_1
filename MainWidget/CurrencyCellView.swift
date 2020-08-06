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
    
    init(exchangeRate: Double, previousExchangeRate: Double, countryISO: String, currencyISO: String) {
        self.exchangeRate = exchangeRate
        self.previousExchangeRate = previousExchangeRate
        self.countryISO = countryISO
        self.currencyISO = currencyISO
    }
    
    var body: some View {
        HStack{
            Image(self.countryISO + "_rhombus")
                .resizable()
                .frame(width: 38.0, height: 38.0)
            Spacer()
            
            Text(self.currencyISO)
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            Text("\(String(format: "%.2f", exchangeRate)) ₽")
                .foregroundColor(.white)
                .font(.title2)
            
            if(previousExchangeRate - exchangeRate < 0) {
                Image("growUp")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 10)
            }
            else{
                Image("goDown")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 10)
            }
            
        }.padding(.horizontal, 10)
    }
}

struct CurrencyCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            let colors = Gradient(colors: [.purple, .blue])
            let conic = LinearGradient(gradient: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            Rectangle().fill(conic)
            CurrencyCellView(exchangeRate: 0.0, previousExchangeRate: 0.0, countryISO: "UK", currencyISO: "GBP")
        }
        
    }
}
