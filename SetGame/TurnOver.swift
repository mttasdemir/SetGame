//
//  TurnOver.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 20.10.2021.
//

import SwiftUI

struct TurnOver: ViewModifier {
    private var side: Side
    
    init(_ side: Side) {
        self.side = side
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if side == .down {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.accentColor)
            }
            content.opacity(side == .down ? 0.0 : 1.0)
        }
    }
    
    enum Side {
        case up
        case down
    }
}

extension View {
    func turnOver(_ side: TurnOver.Side) -> some View {
        modifier(TurnOver(side))
    }
}
