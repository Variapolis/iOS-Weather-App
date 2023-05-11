//
//  Hourly.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack{
            GeometryReader{geometry in
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .ignoresSafeArea(.all)
            }
            VStack{
                Text(modelData.weatherData!.location)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ZStack{
                    Rectangle()
                        .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                    List {
                        ForEach(modelData.weatherData!.forecast.hourly) { hour in
                            HourCondition(current: hour)
                                .listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                        }
                    }
                    .padding(.horizontal)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
