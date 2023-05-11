//
//  ImageURLHelper.swift
//  CourseWork2Starter
//
//  Created by Sam on 11/05/2023.
//

import Foundation
func getWeatherImageURL(icon: String) -> URL{
    return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
}
