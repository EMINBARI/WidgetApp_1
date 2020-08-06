//
//  FetchExchangeData.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 05.08.2020.
//

import Foundation

class ExchangeRateLoader {
    
    func fetchData(complited: @escaping (Result<ExchangeRate, Error>) -> ()){
        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else{
            fatalError("Bad url adress")
        }
        URLSession.shared.dataTask(with: url){ (data, respons, error) in
            if error == nil {
                do{
                    let exchData = try JSONDecoder().decode(ExchangeRate.self, from: data!)
                    complited(.success(exchData))
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
}
