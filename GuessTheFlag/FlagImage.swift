//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Milo Wyner on 7/6/21.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    @State private var rotation = 0.0
    
    func rotate() {
        
    }
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(country: "Italy")
    }
}
