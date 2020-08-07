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
        
        //MARK: - Fetching data from api
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
                        "N/A": Valute(
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
                let dollar = exchData.valute[currenciesSymbols.USD.rawValue]?.value,
                let euro = exchData.valute[currenciesSymbols.EUR.rawValue]?.value,
                let pound = exchData.valute[currenciesSymbols.GBP.rawValue]?.value
                else{
                    return assertionFailure("Error with fetching data")
            }

            guard
                let dollarPrevious = exchData.valute[currenciesSymbols.USD.rawValue]?.previous,
                let euroPrevious = exchData.valute[currenciesSymbols.EUR.rawValue]?.previous,
                let poundPrevious = exchData.valute[currenciesSymbols.GBP.rawValue]?.previous
                else{
                    return assertionFailure("Error with fetching data")
                
            }
            
            let exchangeRateData = WidgetExchangeRate(
                exchangingRate: [
                    currenciesSymbols.USD.rawValue: dollar,
                    currenciesSymbols.EUR.rawValue: euro,
                    currenciesSymbols.GBP.rawValue: pound],
                previousExchangingRate: [
                    currenciesSymbols.USD.rawValue: dollarPrevious,
                    currenciesSymbols.EUR.rawValue:euroPrevious,
                    currenciesSymbols.GBP.rawValue: poundPrevious]
            )
            
            let entryData = WidgetDataModel(
                date: date,
                exchangeData: exchangeRateData
            )
            
            print("--USD previous", exchangeRateData.previousExchangingRate[currenciesSymbols.USD.rawValue]!)
            print("--EUR previous", exchangeRateData.previousExchangingRate[currenciesSymbols.EUR.rawValue]!)
            print("--GBP previous", exchangeRateData.previousExchangingRate[currenciesSymbols.GBP.rawValue]!)
            
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
                exchangingRate: [
                    currenciesSymbols.USD.rawValue: 0.0,
                    currenciesSymbols.EUR.rawValue: 0.0,
                    currenciesSymbols.GBP.rawValue: 0.0],
                
                previousExchangingRate: [
                    currenciesSymbols.USD.rawValue: 0.0,
                    currenciesSymbols.EUR.rawValue: 0.0,
                    currenciesSymbols.GBP.rawValue: 0.0]
            )
        )
        completion(entryData)
    }
    
}
