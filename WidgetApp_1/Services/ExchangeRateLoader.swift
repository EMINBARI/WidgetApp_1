//
//  ExchangeRateLoader.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 06.08.2020.
//

import Foundation

class ExchangeRateLoader {
    
    private let resourceUrl = "https://www.cbr-xml-daily.ru/daily_json.js"
    
    func fetchData(complited: @escaping (Result<ExchangeRate, Error>) -> ()){
        guard let url = URL(string: resourceUrl) else{return}
        URLSession.shared.dataTask(with: url){ (data, respons, error) in
            if error == nil {
                do{
                    let exchData = try JSONDecoder().decode(ExchangeRate.self, from: data!)
                    complited(.success(exchData))
                }
                catch{
                    complited(.failure(error))
                }
            }
        }.resume()
    }
}
