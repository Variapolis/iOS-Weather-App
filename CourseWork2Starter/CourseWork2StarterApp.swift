//
//  CourseWork2StarterApp.swift
//  CourseWork2Starter
//
//  Created by Variapolis.
//

import SwiftUI

@main
struct CourseWork2StarterApp: App {
    @StateObject var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
