//
//  CardViewModel.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 28.09.2021.
//

import Foundation
import SwiftUI

class CardViewModel: Identifiable {
    let uid = UUID()
    private(set) var card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var color: Color {
        var cardColor: Color
        switch card.colour {
            case .purple: cardColor = Color.purple
            case .green: cardColor = Color.green
            case .red: cardColor = Color.red
        }
        return cardColor
    }
    
    var figure: Figure {
        card.figure
    }
    
    var numberOfFigure: Int {
        switch card.numberOfFigure {
            case .single: return 0
            case .double: return 1
            case .triple: return 2
        }
    }
    
    var pattern: Pattern {
        card.pattern
    }
    
    var selected: Bool {
        card.selected
    }
    
    var opacity: Double {
        switch card.pattern {
            case .empty,
                 .full: return 1.0
            case .striped: return 0.5
        }
    }
    
    var cardId: Int {
        card.id
    }
    
    var backgroundColor: Color {
        switch card.backgroundRecColor {
            case .white: return Color.white
            case .gray: return Color.gray
        }
    }
}

