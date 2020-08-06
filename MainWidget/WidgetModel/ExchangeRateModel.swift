//
//  ExchangeRateModel.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 06.08.2020.
//

import SwiftUI
import WidgetKit

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
