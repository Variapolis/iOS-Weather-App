//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        
        ZStack {

            // Use ZStack for background images
            
            VStack {
                Text("")
                Spacer()
                Text("This is a mixed view with weather \n and air quality data,\n refer to Figure 5 to see what data must be displayed here")
                Spacer()
                if let pm25 = modelData.airData?.list.first?.components.pm2_5 {
                    Text(String(pm25))
                } else {
                    Text("N/A")
                }

                    }
                    
                
                .foregroundColor(.black)
                .shadow(color: .black,  radius: 0.5)
                
            }.ignoresSafeArea(edges: [.top, .trailing, .leading])
        }
    }

    

