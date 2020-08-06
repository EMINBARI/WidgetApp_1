//
//  FetchExchangeData.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 05.08.2020.
//

import Foundation


class ApiService {
    
//    func fetchData(){
//
//        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else{
//            fatalError("Invalid URL adress")
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        self.users = try JSONDecoder().decode(ExchangeRate.self, from: data)
//                    } catch let err {
//                        print("Error: \(err)")
//                    }
//                }
//            } else {
//                print("HTTPURLResponse code: \(response.statusCode)")
//            }
//        }.resume()
//    }
//
//    func fetchData(complited: @escaping (ExchangeRate?) -> ()){
//
//        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else{
//            fatalError("Invalid URL adress")
//        }
//
//        URLSession.shared.dataTask(with: url){ (data, respons, error) in
//
//            guard let data = data, error == nil else{
//                DispatchQueue.main.async {
//                    complited(nil)
//                }
//
//                return
//            }
//
//            let exchData = try? JSONDecoder().decode(ExchangeRate.self, from: data)
//
//            DispatchQueue.main.async {
//                complited(exchData)
//            }
//
//        }.resume()
//    }
    
}
