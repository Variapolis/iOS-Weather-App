//
//  HourCondition.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct HourCondition: View {
    var current : Current
  
    
    var body: some View {
        HStack {
            VStack {
                Text(UnixToDateFormat(timestamp: current.dt, format: "ha"))
                Text(UnixToDateFormat(timestamp: current.dt, format: "E"))
            }
            AsyncImage(url: getWeatherImageURL(icon: current.weather[0].icon))
            Text("\(Int(current.temp))ºC")
            Text(current.weather[0].weatherDescription.rawValue.capitalized)

        }.padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
