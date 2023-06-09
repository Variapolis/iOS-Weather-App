//
//  Conditions.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            GeometryReader{geometry in
                Image("background2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .ignoresSafeArea(.all)
            }
            VStack {
                Text(modelData.weatherData!.location)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                VStack{
                    
                    //          Temperature Info
                    VStack {
                        Text("\((Int)(modelData.weatherData!.forecast.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            AsyncImage(url: getWeatherImageURL(icon: modelData.weatherData!.forecast.current.weather[0].icon))
                            Text(modelData.weatherData!.forecast.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        }
                        HStack{
                            Text("H: \(Int(modelData.weatherData!.forecast.daily.first!.temp.max))ºC")
                                .padding(.horizontal)
                            Text("Low: \(Int(modelData.weatherData!.forecast.daily.first!.temp.min))ºC")
                                .padding(.horizontal)
                            
                        }.padding(.vertical)
                        
                        Text("Feels Like: \((Int)(modelData.weatherData!.forecast.current.feelsLike))ºC")
                            .foregroundColor(.black)
                    }.padding()
                    HStack{
                        Text("Wind Speed: \(Int(modelData.weatherData!.forecast.current.windSpeed))m/s")
                            .padding(.horizontal, 25.0)
                        Text("Direction: \(convertDegToCardinal(deg: modelData.weatherData!.forecast.current.windDeg))")
                            .padding(.horizontal, 25.0)
                    }
                    .padding(.vertical)
                    HStack{
                        Text("Humidity: \(Int(modelData.weatherData!.forecast.current.humidity))%")
                            .padding(.horizontal, 25.0)
                        Text("Direction: \( modelData.weatherData!.forecast.current.pressure)hPg")
                            .padding(.horizontal, 25.0)
                    }
                    .padding(.top, 50.0)
                    HStack{
                        Image(systemName: "sunrise")
                        Text(UnixToDateFormat(timestamp: modelData.weatherData!.forecast.current.sunrise!, format: "h:mma"))
                        Image(systemName: "sunset")
                        Text(UnixToDateFormat(timestamp: modelData.weatherData!.forecast.current.sunset!, format: "h:mma"))

                    }
                    .padding(.vertical)
                    
                    
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
