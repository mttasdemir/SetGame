//
//  SetDeckViewModel.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 28.09.2021.
//

import Foundation
import SwiftUI

class SetDeckViewModel: ObservableObject {
    
    @Published private var setDeck = SetDeck() 
    
    var deck: [CardViewModel] {
        var d = [CardViewModel]()
        for index in setDeck.cards.indices {
            d.append(CardViewModel(setDeck.cards[index]))
        }
        return d
    }
    
    func select(_ cardvm: CardViewModel) {
        setDeck.select(with: cardvm.cardId)
    }
    
    func dealMoreCard() {
        setDeck.dealCards(of: 1)
    }
    
    func newGame() {
        setDeck.newGame()
    }
}
