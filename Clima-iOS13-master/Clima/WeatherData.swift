//
//  WeatherData.swift
//  Clima
//
//  Created by User on 27/05/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

struct WeatherData : Codable {
    var name : String
    var main : Main
    var weather : [Weather]
}

struct Weather : Codable {
    var id : Int
    var description : String
}

struct Main : Codable {
    var temp : Double
}
