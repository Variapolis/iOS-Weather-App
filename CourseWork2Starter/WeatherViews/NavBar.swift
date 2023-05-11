//
//  NavBar.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
           Home()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("City")
                }
            CurrentWeatherView()
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("WeatherNow")
                }
            
            HourlyView()
                .tabItem{
                    Image(systemName: "clock.fill")
                    Text("Hourly Summary")
                }
            ForecastView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Forecast")
                }
            PollutionView()
                .tabItem {
                    Image(systemName: "aqi.high")
                    Text("Pollution")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

