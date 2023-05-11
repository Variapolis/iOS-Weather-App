//
//  Forecast.swift
//  Coursework2
//
//  Created by Variapolis.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        ZStack{
            GeometryReader{geometry in
                Image("background2")
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
                    List{
                        ForEach(modelData.weatherData!.forecast.daily) { day in
                            DailyView(day: day)
                                .listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
    }
}


struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
