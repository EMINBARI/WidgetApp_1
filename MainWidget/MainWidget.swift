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
                    exchangeRate: data.exchangeData.exchangingRate["USD"]!,
                    previousExchangeRate: data.exchangeData.previousExchangingRate["USD"]!,
                    countryISO: "USA",
                    currencyISO: "USD"
                )
                Spacer()
                CurrencyCellView(
                    exchangeRate: data.exchangeData.exchangingRate["EUR"]!,
                    previousExchangeRate: data.exchangeData.previousExchangingRate["EUR"]!,
                    countryISO: "EU",
                    currencyISO: "EUR"
                )
                Spacer()
                CurrencyCellView(
                    exchangeRate: data.exchangeData.exchangingRate["GBP"]!,
                    previousExchangeRate: data.exchangeData.previousExchangingRate["GBP"]!,
                    countryISO: "UK",
                    currencyISO: "GBP"
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
