//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
   
    var body: some View {
        
        HStack {
            Text("Weather icon")
            Spacer()
            VStack {
                Text("Weather description")
                Text("Day and 2 digit date")
                
            }
            Spacer()
            Text("high temp and low temp")
           
        }.padding()
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
