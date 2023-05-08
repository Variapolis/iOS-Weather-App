//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 11/03/2023.
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
                Text("This is the search view that will allow user to enter new location and the .OnCommit should handle conversion to geo coords and then reversed to get the location if it exists. \n The geo coords are then used to update the weather data for the new location and all views should be updated in rdeal time.\n There is no code to do this - you must create this code.")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
