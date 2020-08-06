//
//  Hero.swift
//  WidgetApp_1
//
//  Created by Emin Bari on 05.08.2020.
//

import Foundation

struct  HeroModel:Decodable {
    let localized_name: String
    let attack_type: String
    let img: String
    let icon: String
    let base_health: Int
}
