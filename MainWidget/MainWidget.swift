//
//  MainWidget.swift
//  MainWidget
//
//  Created by Emin Bari on 05.08.2020.
//

import WidgetKit
import SwiftUI

struct WidgetView: View {
    var data: DataProvider.Entry
    
    var body: some View {
        ZStack {
            let colors = Gradient(colors: [.purple, .blue])
            let rectangleGradient = LinearGradient(
                gradient: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Rectangle().fill(rectangleGradient)
            
            VStack(alignment: .leading) {
                Spacer()
                CurrencyCellView(
                    exchangeRate: data.exchangeData.exchangingRate[currenciesSymbols.USD.rawValue]!,
                    previousExchangeRate: data.exchangeData.previousExchangingRate[currenciesSymbols.USD.rawValue]!,
                    countryISO: countrySymbols.USA.rawValue,
                    currencyISO: currenciesSymbols.USD.rawValue
                )
                Spacer()
                CurrencyCellView(
                    exchangeRate: data.exchangeData.exchangingRate[currenciesSymbols.EUR.rawValue]!,
                    previousExchangeRate: data.exchangeData.previousExchangingRate[currenciesSymbols.EUR.rawValue]!,
                    countryISO: countrySymbols.EU.rawValue,
                    currencyISO: currenciesSymbols.EUR.rawValue
                )
                Spacer()
                CurrencyCellView(
                    exchangeRate: data.exchangeData.exchangingRate[currenciesSymbols.GBP.rawValue]!,
                    previousExchangeRate: data.exchangeData.previousExchangingRate[currenciesSymbols.GBP.rawValue]!,
                    countryISO: countrySymbols.UK.rawValue,
                    currencyISO: currenciesSymbols.GBP.rawValue
                )
                Spacer()
            }
        }
    }
}


@main
struct Config: Widget {
    private let kind: String = "MainWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DataProvider()

        ) { data in
            WidgetView(data: data)
        }
        .configurationDisplayName(Text("Exchange rates"))
        .supportedFamilies([.systemMedium])
        .description(Text("Shows exchanges rates"))
        
    }
}
