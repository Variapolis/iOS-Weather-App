//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 10/03/2023.
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
                
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity: \(modelData.forecast!.current.humidity)%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure: \(modelData.forecast!.current.pressure)hPa")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                Spacer()
                HStack{
                    // Image Goes here!
                    AsyncImage(url: modelData.getWeatherImageURL())
                    Text(modelData.forecast!.current.weather.first!.weatherDescription.rawValue.capitalized)
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                    
                }
                
            }
        }
    }
}
