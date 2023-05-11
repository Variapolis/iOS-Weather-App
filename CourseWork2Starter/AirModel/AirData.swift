//
//  AirData.swift
//  CourseWork2Starter
//
//  Created by Variapolis.
//

import Foundation

struct AirData: Codable {
    let coord: Coord
    let list: [AirList]
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct AirList: Codable {
    let main: MainInfo
    let components: Components
    let dt: Int
}

struct MainInfo: Codable {
    let aqi: Int
}

struct Components: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}
