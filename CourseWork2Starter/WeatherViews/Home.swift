//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by Variapolis.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                    }
                    .padding(.top, 35.0)
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                }
                
                Spacer()
                
                Text(modelData.weatherData!.location)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.weatherData!.forecast.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Text("Temp: \((Int)(modelData.weatherData!.forecast.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity: \(modelData.weatherData!.forecast.current.humidity)%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure: \(modelData.weatherData!.forecast.current.pressure)hPa")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                Spacer()
                HStack{
                    AsyncImage(url: getWeatherImageURL(icon: modelData.weatherData!.forecast.current.weather[0].icon)) { image in
                        image
                    } placeholder: {
                        ProgressView().progressViewStyle(.circular)
                    }
                    Text(modelData.weatherData!.forecast.current.weather.first!.weatherDescription.rawValue.capitalized)
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.weatherData!.forecast.lat, lon: modelData.weatherData!.forecast.lon)
                    
                    
                }
                
            }
        }
    }
}
