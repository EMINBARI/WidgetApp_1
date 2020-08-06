//
//  ContentView.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 05.08.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var exchangeRateVM = ExchangeRateViewModel()
    
    
    var body: some View {

        let data = exchangeRateVM.exchangeData?.valute["USD"]?.name
        
        VStack() {
            if (exchangeRateVM.exchangeData != nil){
                Text("\((exchangeRateVM.exchangeData?.valute["USD"]!.name)!)")
            }
            else{
                Text("Loading")
               
            }
            Button(action: {
                print("Fetching...")
                self.exchangeRateVM.fetchData()
                print(exchangeRateVM.exchangeData?.valute["USD"]?.name)
                
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(width: 120, height: 40)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)
                    Text("Fetch").foregroundColor(Color.white)
                }
            })
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
