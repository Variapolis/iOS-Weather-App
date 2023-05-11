//
//  PollutionView.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(modelData.userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                VStack{
                    
                    //          Temperature Info
                    VStack {
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            AsyncImage(url: getWeatherImageURL(icon: modelData.forecast!.current.weather[0].icon))
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        }
                        HStack{
                            Text("H: \(Int(modelData.forecast!.daily.first!.temp.max))ºC")
                                .padding(.horizontal)
                            Text("Low: \(Int(modelData.forecast!.daily.first!.temp.min))ºC")
                                .padding(.horizontal)
                            
                        }.padding(.vertical)
                        
                        Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                            .foregroundColor(.black)
                    }.padding()
                    Text("Air Quality Data:")
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                    HStack{
                        PollutantView(image: "so2", value: modelData.airData!.list[0].components.so2)
                        PollutantView(image: "no", value: modelData.airData!.list[0].components.no)
                        PollutantView(image: "voc", value: modelData.airData!.list[0].components.nh3)
                        PollutantView(image: "pm", value: modelData.airData!.list[0].components.pm2_5)
                    }.padding(.horizontal)
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}



