//
//  ShakeEffect.swift
//  GuessTheFlag
//
//  Created by Milo Wyner on 7/22/21.
//

import SwiftUI

struct Shake: GeometryEffect {
    var offset: CGFloat = 20
    var shakesPerUnit = 4
    var animatableData: CGFloat
    
    init(toggle: Bool) {
        // trigger animation
        animatableData = toggle ? 1 : 0
        // prevent animation from reversing
        offset *= toggle ? 1 : -1
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: -offset * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

