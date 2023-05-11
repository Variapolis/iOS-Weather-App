//
//  DailyView.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
   
    var body: some View {
        
        HStack {
            AsyncImage(url: getWeatherImageURL(icon: day.weather[0].icon))
            Spacer()
            VStack {
                Text(day.weather[0].weatherDescription.rawValue.capitalized)
                // TODO: Fix date to be day and number only
                Text(UnixToDateFormat(timestamp: day.dt, format: "EEEE d"))
                
            }
            Spacer()
            Text("\(Int(day.temp.max))ºC / \(Int(day.temp.min))ºC")
           
        }.padding()
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().weatherData!.forecast.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
