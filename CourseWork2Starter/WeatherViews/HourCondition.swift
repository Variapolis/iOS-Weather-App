//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourCondition: View {
    var current : Current
  
    
    var body: some View {
        HStack {
            VStack {
                Text("This view is hourly summary for the next 48 hours for the location,\n see  Figure 3 what this view must show and build it")

            }
            Spacer()

        }.padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
