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
    
    let imageType = "_circled"
    let dynamicsImagesSize: CGFloat = 18.0
    let countryImagesSize: CGFloat = 32.0
    let imagePadding: CGFloat = 10.0
    
    let growUpImageName = "growUp"
    let goDownImageName = "goDown"
    let equalImageName = "equal"
    
    var dynamicsImage: String {
        get{
            if previousExchangeRate < exchangeRate {
                return growUpImageName
            } else if previousExchangeRate > exchangeRate {
                return goDownImageName
            } else {
                return equalImageName
            }
        }
    }
        
    var body: some View {
        HStack {
            Image(self.countryISO + imageType)
                .resizable()
                .frame(width: countryImagesSize, height: countryImagesSize)
            Spacer()
            Text(self.currencyISO)
                .foregroundColor(.white)
                .font(.headline)
            Spacer()
            Text("\(String(format: "%.2f", exchangeRate)) ₽")
                .foregroundColor(.white)
                .font(.title2)
            
            Image(dynamicsImage)
                .resizable()
                .frame(width: dynamicsImagesSize, height: dynamicsImagesSize)
                .padding(.leading, imagePadding)
            
        }.padding(.horizontal, 10)
    }
}

//MARK: - That's for debuggin preview
struct CurrencyCellViewPreviews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            let colors = Gradient(colors: [.purple, .blue])
            let rectangleGradient = LinearGradient(
                gradient: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Rectangle().fill(rectangleGradient)
            
            CurrencyCellView(
                exchangeRate: 0.0,
                previousExchangeRate: 0.0,
                countryISO: countrySymbols.UK.rawValue,
                currencyISO: currenciesSymbols.GBP.rawValue
            )
        }
        
    }
}
