//
//  WeatherManager.swift
//  Clima
//
//  Created by User on 26/05/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    
    func didUptadeWeather(_ weatherManager: WeatherManager, weather : WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=fc8bc80934128a4ea9aae978868ab321&units=metric"

    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude : CLLocationDegrees, longitude: CLLocationDegrees) {
        
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String){
        // Criar uma URl
        
        guard let url = URL(string: urlString) else { return }
        
        // Criar uma URlSession
        
        let session = URLSession(configuration: .default)
        
        // dar uma task para a sessão
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error!)
                return
            }
            if let safeData = data {
                if let weatherModel = self.parseJSON(safeData) {
                    self.delegate?.didUptadeWeather(self, weather: weatherModel)
                }
            } else { return }
        }
        
        // Start the task
        
        task.resume()
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }

}
