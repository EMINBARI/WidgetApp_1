//
//  ExchangeRateViewModel.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 05.08.2020.
//

import Foundation

class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeData: ExchangeRate?
    
    init() {
        fetchData()
    }
        
    func fetchData(){
        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else{
            fatalError("Invalid URL adress")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("ERROR!!!")
                print(err.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                
                do {
                    self.exchangeData = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    print("--fetch--")
                    print(self.exchangeData?.valute.count)
                } catch let err {
                    print("Error: \(err)")
                }
                
            } else {
                print("HTTPURLResponse code: \(response.statusCode)")
            }
            
        }.resume()
    }
}
