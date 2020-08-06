//
//  DataProvider.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 06.08.2020.
//

import SwiftUI
import WidgetKit

struct DataProvider: TimelineProvider{
    
    func timeline(with context: Context, completion: @escaping (Timeline<WidgetDataModel>) -> ()) {
        let date = Date()

        ExchangeRateLoader().fetchData{ result in
            let exchData: ExchangeRate
            if case .success(let fetchedExchData) = result {
                exchData = fetchedExchData
            } else{
                exchData = ExchangeRate(
                    date: "",
                    previousDate: "",
                    previousURL: "",
                    timestamp: "",
                    valute: [
                        "": Valute(
                                id: "",
                                numCode: "",
                                charCode: "",
                                nominal: 0,
                                name: "",
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
                exchangingRate: ["USD": 00.0, "EUR":00.0, "GBP": 00.0],
                previousExchangingRate: ["USD": 00.0, "EUR":00.0, "GBP": 00.0]
            )
        )
        completion(entryData)
    }
    
}
