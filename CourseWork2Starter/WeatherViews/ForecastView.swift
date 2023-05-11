//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
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
            Rectangle()
                .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                .padding(.top, 75.0)
            VStack{
                Text(modelData.userLocation)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                            .listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.4))
                    }
                }
                .padding(.horizontal)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
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
