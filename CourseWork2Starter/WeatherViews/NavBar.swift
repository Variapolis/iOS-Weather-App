//
//  NavBar.swift
//  Coursework2
//
//  Created by G Lukka.
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
                    
                    Text("WeatherNow")
                }
            
            HourlyView()
                .tabItem{
                    
                    Text("Hourly Summary")
                }
            ForecastView()
                .tabItem {
                    
                    Text("Forecast")
                }
            PollutionView()
                .tabItem {
                    
                    Text("Pollution")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

