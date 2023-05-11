//
//  ImageURLHelper.swift
//  CourseWork2Starter
//
//  Created by Variapolis.
//

import Foundation
func getWeatherImageURL(icon: String) -> URL{
    return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
}
