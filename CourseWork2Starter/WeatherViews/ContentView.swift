//
//  ContentView.swift
//  CourseWork2Starter
//
//  Created by GirishALukka on 16/03/2023.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavBar()
    }
}
// Weather: https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude%20={part}&appid={API%20key}
// Air Quality: https://api.openweathermap.org/data/2.5/air_pollution?lat={lat}&lon={lon}&appid=0835716d6f39fc54217361ebd0d39a9e
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
