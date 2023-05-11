//
//  WeatherData.swift
//  CourseWork2Starter
//
//  Created by Sam on 11/05/2023.
//

import Foundation

struct WeatherData: Codable, Identifiable {
    var id = UUID()
    var location : String
    var forecast: Forecast
    var air: AirData
}
