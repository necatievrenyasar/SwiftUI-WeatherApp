//
//  DayListViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Evren Yaşar on 28.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation

enum WeatherType {
    case snow, rain, sun, clouds
    
    var icon: String {
        switch self {
        case .clouds:
            return "cloud"
        case .rain:
            return "cloud.rain"
        case .snow:
            return "cloud.snow"
        case .sun:
            return "sun.min"
        }
    }
}

struct DayRowModel: Identifiable {
    var id = UUID()
    var day: String
    var date: String
    var degree: String
    var weather: WeatherType
}

class DayListViewModel: ObservableObject {
    
    @Published var datas: [DayRowModel] = []
    
    private var mockData: [DayRowModel] {
        return [.init(day: "Sunday", date: "10 Jun", degree: "19", weather: .sun),
                .init(day: "Monday", date: "11 Jun", degree: "12", weather: .rain),
                .init(day: "Wednesday", date: "12 Jun", degree: "15", weather: .sun),
                .init(day: "Thursday", date: "13 Jun", degree: "-2", weather: .snow),
                .init(day: "Friday", date: "14 Jun", degree: "-4", weather: .snow),]
    }
    
    func start() {
        datas = mockData
    }
    
    func fetchData() {
        //api.openweathermap.org/data/2.5/forecast?q=London
        //https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b6907d289e10d714a6e88b30761fae22
        //api.openweathermap.org/data/2.5/forecast?q=London
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=49b4f4f80b7a69e2cff0fd5ba62f0ec1") else {return}
        datas.removeAll()
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("[Error] \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(WeatherParser.self, from: data)
                    let finalData = result.list.compactMap { (ref) -> DayRowModel? in
                        if let day = self.dayFilter(data: ref) {
                            return self.convertData(day)
                        }
                        return nil
                    }
                    self.datas = finalData
                }catch let error {
                    print("[Error] \(error.localizedDescription)")
                }
                
            }
        }.resume()
    }
    
    private func dayFilter(data: WeatherAndTime) -> WeatherAndTime? {
        let timeInterval = Double(data.dt)
        let convertedDate = Date(timeIntervalSince1970: timeInterval)
        if convertedDate.formatter("HH") == "12" {
            return data
        }
        return data
    }
    
    
    private func convertData(_ data: WeatherAndTime) -> DayRowModel? {
        print("aaaa \(data.dtTxt) - \(kelvinToCelsius(data.mainTemp.temp))")
        
        let timeInterval = Double(data.dt)
        let convertedDate = Date(timeIntervalSince1970: timeInterval)
        return DayRowModel(day: convertedDate.formatter("EEEE"), date: convertedDate.formatter("yyyy-MMM-dd"), degree: "40", weather:.sun)
    }
    
    
    
    func kelvinToCelsius(_ kelvin: Double) -> Double {
        kelvin - 273.15
    }
    
}


struct WeatherParser: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherAndTime]
}

// MARK: - List
struct WeatherAndTime: Codable {
    let dt: Int
    let mainTemp: MainTemp
    let weather: [Weather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, weather, mainTemp = "main"
        case dtTxt = "dt_txt"
    }
}

struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct MainTemp: Codable {
    let temp: Double
}

enum MainEnum: String, Codable {
   
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}



enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case lightSnow = "light snow"
    case scatteredClouds = "scattered clouds"
    case overcastClouds = "overcast clouds"
}
