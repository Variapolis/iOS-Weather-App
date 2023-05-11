//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by Variapolis.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var isSearchOpen: Bool
    @State var location = ""
    @Binding var userLocation: String
    
    var body: some View {
        Spacer()
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack{
                TextField("Enter New Location", text: self.$location, onCommit: {
                    
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            Task.detached{ // Executes async helper method synchronously as a Task
                                let newForecast = try await modelData.downloadData(lat: lat, lon: lon)
                                DispatchQueue.main.async {
                                    modelData.forecast = newForecast
                                    userLocation = modelData.userLocation
                                }
                            }
                            isSearchOpen.toggle()
                        }
                        
                        
                    }//GEOCorder
                } //Commit
                          
                )// TextField
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                //.background(Color("background"))
                .cornerRadius(15) // TextField
                
            }//VStak
            
            
        }// Zstack
        Spacer()
    }// Some
    
} //View
