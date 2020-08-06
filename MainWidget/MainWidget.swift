//
//  MainWidget.swift
//  MainWidget
//
//  Created by Emin Bari on 05.08.2020.
//

import WidgetKit
import SwiftUI

struct WidgetDataModel: TimelineEntry {
    var date: Date
    var exchangeData: WidgetExchangeRate
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 90)
    }
}

struct WidgetExchangeRate{
    var exchangingRate: [String: Double]
    var previousExchangingRate: [String: Double]
}

class DataProvider: TimelineProvider{
    
    @ObservedObject private var exchangeRateVM = ExchangeRateViewModel()
    
    func timeline(with context: Context, completion: @escaping (Timeline<WidgetDataModel>) -> ()) {
        let date = Date()
        print(exchangeRateVM.exchangeData?.valute.count as Any)
                
        guard
            let dollar = exchangeRateVM.exchangeData?.valute["USD"]?.value,
            let euro = exchangeRateVM.exchangeData?.valute["USD"]?.value,
            let pound = exchangeRateVM.exchangeData?.valute["GBP"]?.value
            else{
                return
        }
                
        guard
            let dollarPrevious = exchangeRateVM.exchangeData?.valute["USD"]?.previous,
            let euroPrevious = exchangeRateVM.exchangeData?.valute["USD"]?.previous,
            let poundPrevious = exchangeRateVM.exchangeData?.valute["GBP"]?.previous
            else{
                return
        }
        
        let exchangeRateData = WidgetExchangeRate(
            exchangingRate: ["USD": dollar, "EUR": euro, "GBP": pound],
            previousExchangingRate: ["USD": dollarPrevious, "EUR":euroPrevious, "GBP": poundPrevious]
        )
        
        let entryData = WidgetDataModel(
            date: date,
            exchangeData: exchangeRateData
        )
        
        print("--USD previous", exchangeRateData.previousExchangingRate["USD"]!)
        print("--EUR previous", exchangeRateData.previousExchangingRate["EUR"]!)
        print("--GBP previous", exchangeRateData.previousExchangingRate["GBP"]!)
        
        let refreshDate = Calendar.current.date(byAdding: .second, value: 1, to: date)!
    
        let timeLine = Timeline(entries: [entryData], policy: .after(refreshDate))
        
        print("updated")
        
        completion(timeLine)
    }
    
    func snapshot(with context: Context, completion: @escaping (WidgetDataModel) -> ()) {
        
        let date = Date()
        
        let entryData = WidgetDataModel(
            date: date,
            exchangeData: WidgetExchangeRate (
                exchangingRate: ["USD": 00.0, "EUR":00.0, "GBP": 00.0],
                previousExchangingRate: ["USD": 00.0, "EUR":00.0, "GBP": 00.0]
            )
        )
        
        completion(entryData)
    }
    
}

struct WidgetView:View {
    
    var data: DataProvider.Entry
    
    var body: some View{
        ZStack{
            let colors = Gradient(colors: [.purple, .blue])
            let conic = LinearGradient(gradient: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            Rectangle().fill(conic)
            
            VStack(alignment: .leading){
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

struct LoadingWidgetView:View {
    var body: some View{
        ZStack{
            let colors = Gradient(colors: [.purple, .blue])
            let conic = LinearGradient(gradient: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            Rectangle().fill(conic)
            Text("Loading...")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}


@main
struct Config: Widget {
    private let kind: String = "MainWidget"
    var body: some WidgetConfiguration{
        
//MARK: - new method but wo placeholder
//        StaticConfiguration(
//            kind: kind,
//            provider: DataProvider())
//        { data in
//            WidgetView(data: data)
//        }
//        .configurationDisplayName(Text("Exchange rates"))
//        .supportedFamilies([.systemMedium])
//        .description(Text("Shows exchanges rates"))
        
        
//MARK: - deprecated method
        StaticConfiguration(
            kind: kind,
            provider: DataProvider(),
            placeholder: LoadingWidgetView(),
            content: { data in
                WidgetView(data: data)
            }
        )
        .configurationDisplayName(Text("Exchange rates"))
        .supportedFamilies([.systemMedium])
        .description(Text("Shows exchanges rates"))
        
    }
}
