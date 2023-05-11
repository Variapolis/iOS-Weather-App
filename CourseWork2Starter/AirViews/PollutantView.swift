//
//  PollutantView.swift
//  CourseWork2Starter
//
//  Created by Variapolis.
//

import SwiftUI

struct PollutantView: View {
    let image : String
    let value : Double
    
    var body: some View {
        VStack {
            Image(image)
            Text(String(value))
        }
    }
    
}

struct PollutantView_Previews: PreviewProvider {
    static var previews: some View {
        PollutantView(image: "so2", value: 3.55)
    }
}
