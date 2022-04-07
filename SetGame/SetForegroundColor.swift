//
//  SetForegroundColor.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 22.10.2021.
//

import SwiftUI

struct SetForegroundColor: AnimatableModifier {
    
    private var color: Double
    
    init(_ color: Double) {
        self.color = color
    }
    
    var animatableData: Double {
        get { color }
        set { color = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.yellow).opacity(color)
        }
    }
}
