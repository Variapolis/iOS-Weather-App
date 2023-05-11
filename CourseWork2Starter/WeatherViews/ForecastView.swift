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
            Image("background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text(modelData.userLocation)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ZStack{
                    Rectangle()
                        .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                    List{
                        ForEach(modelData.forecast!.daily) { day in
                            DailyView(day: day)
                                .listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .onAppear {
                Task.init {
                    self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                }
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
