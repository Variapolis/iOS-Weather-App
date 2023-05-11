//
//  ContentView.swift
//  CourseWork2Starter
//
//  Created by Variapolis.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavBar()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
