//
//  DataProvider.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 06.08.2020.
//

import SwiftUI
import WidgetKit

struct DataProvider: TimelineProvider {
    
    func timeline(with context: Context, completion: @escaping (Timeline<WidgetDataModel>) -> ()) {
        let date = Date()
        let noDataPlaceholder = "N/A"
        
        ExchangeRateLoader().fetchData { result in
            let exchData: ExchangeRate
            if case .success(let fetchedExchData) = result {
                exchData = fetchedExchData
            } else{
                exchData = ExchangeRate(
                    date: noDataPlaceholder,
                    previousDate: noDataPlaceholder,
                    previousURL: noDataPlaceholder,
                    timestamp: noDataPlaceholder,
                    valute: [
                        noDataPlaceholder: Valute(
                                id: noDataPlaceholder,
                                numCode: noDataPlaceholder,
                                charCode: noDataPlaceholder,
                                nominal: 0,
                                name: noDataPlaceholder,
                                value: 0.0,
                                previous: 0.0)
                    ]
                )
            }
            
            guard
                let dollar = exchData.valute["USD"]?.value,
                let euro = exchData.valute["EUR"]?.value,
                let pound = exchData.valute["GBP"]?.value
                else{
                    fatalError("Error with fetching data")
            }

            guard
                let dollarPrevious = exchData.valute["USD"]?.previous,
                let euroPrevious = exchData.valute["EUR"]?.previous,
                let poundPrevious = exchData.valute["GBP"]?.previous
                else{
                    fatalError("Error with fetching data")
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
            
            let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
            let timeLine = Timeline(entries: [entryData], policy: .after(refreshDate))
            
            print("updated")
            
            completion(timeLine)
        }
    }
    
    func snapshot(with context: Context, completion: @escaping (WidgetDataModel) -> ()) {
        let date = Date()
        let entryData = WidgetDataModel(
            date: date,
            exchangeData: WidgetExchangeRate (
                exchangingRate: ["USD": 0.0, "EUR": 0.0, "GBP": 0.0],
                previousExchangingRate: ["USD": 0.0, "EUR": 0.0, "GBP": 0.0]
            )
        )
        completion(entryData)
    }
    
}
