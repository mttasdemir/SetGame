//
//  Card.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 27.09.2021.
//

import Foundation

struct Card: Identifiable {
    
    init(id: Int, figure: Figure, colour: Colour, numberOfFigure: Numeral, pattern: Pattern, selected: Bool = false) {
        self.id = id
        self.figure = figure
        self.colour = colour
        self.numberOfFigure = numberOfFigure
        self.pattern = pattern
        self.selected = selected
    }
    
    let id: Int
    let figure: Figure
    let colour: Colour
    let numberOfFigure: Numeral
    let pattern: Pattern
    
    var backgroundRecColor = BackgroundColor.white
    var selected: Bool = false
    var dealed: Bool = false
    var inSet: Bool = false
    
}

struct SetDeck {
    private(set) var cards: [Card]
    
    init() {
        cards = []
        shuffleCards()
    }
    
    mutating func shuffleCards() {
        var cardId = 1
        for figure in Figure.allCases {
            for color in Colour.allCases {
                for numeral in Numeral.allCases {
                    for pattern in Pattern.allCases {
                        cards.append(Card(id: cardId, figure: figure, colour: color, numberOfFigure: numeral, pattern: pattern))
                        cardId += 1
                    }
                }
            }
        }
        cards.shuffle()
        dealCards(of: 12)
    }
    
    mutating func dealCards(of count: Int) {
        var count = count
        for index in cards.indices {
            if !cards[index].dealed && !cards[index].inSet {
                cards[index].dealed = true
                count -= 1
            }
            if count == 0 {
                break
            }
        }
    }
    
    mutating func newGame() {
        cards.removeAll()
        shuffleCards()
    }
    
    mutating func select(with id: Int) {
        
        if let index = cards.firstIndex(where: { $0.id == id }) {
            if countOfSelectedCards <= 2 {
                unselectCard(with: index)
            }
            else {
                if !isSet() {
                    clearSelectedCards()
                    select(with: id)
                }
                else {
                    removeCardsInSet()
                }
            }
        }
    }
    
    mutating func unselectCard(with index: Int) {
        cards[index].backgroundRecColor = cards[index].selected ? BackgroundColor.white : BackgroundColor.gray
        cards[index].selected.toggle()
        cards[index].inSet.toggle()
    }
    
    mutating func removeCardsInSet() {
        //cards.removeAll(where: { $0.selected })
        for index in cards.indices {
            if cards[index].selected {
                cards[index].inSet = true
                cards[index].dealed = false
                cards[index].selected.toggle()
                cards[index].backgroundRecColor = BackgroundColor.white
            }
        }
    }
    
    mutating func clearSelectedCards() {
        for index in cards.indices {
            if cards[index].selected {
                unselectCard(with: index)
            }
        }
    }
    
    var countOfSelectedCards: Int {
        cards.filter({ $0.selected }).count
    }
    
    mutating func isSet() -> Bool {
        let selectedCards = cards.filter({ $0.selected })
        guard selectedCards.count == 3 else { fatalError("Too much selected cards") }
        
        if !((selectedCards[0].figure == selectedCards[1].figure && selectedCards[1].figure == selectedCards[2].figure) ||
            (selectedCards[0].figure != selectedCards[1].figure && selectedCards[1].figure != selectedCards[2].figure && selectedCards[0].figure != selectedCards[2].figure))
           ||
            !((selectedCards[0].colour == selectedCards[1].colour && selectedCards[1].colour == selectedCards[2].colour) ||
                (selectedCards[0].colour != selectedCards[1].colour && selectedCards[1].colour != selectedCards[2].colour && selectedCards[0].colour != selectedCards[2].colour))
            ||
            !((selectedCards[0].numberOfFigure == selectedCards[1].numberOfFigure && selectedCards[1].numberOfFigure == selectedCards[2].numberOfFigure) ||
                (selectedCards[0].numberOfFigure != selectedCards[1].numberOfFigure && selectedCards[1].numberOfFigure != selectedCards[2].numberOfFigure && selectedCards[0].numberOfFigure != selectedCards[2].numberOfFigure))
            ||
            !((selectedCards[0].pattern == selectedCards[1].pattern && selectedCards[1].pattern == selectedCards[2].pattern) ||
                (selectedCards[0].pattern != selectedCards[1].pattern && selectedCards[1].pattern != selectedCards[2].pattern && selectedCards[0].pattern != selectedCards[2].pattern))
        {
            return false
        }
        
        return true
    }
    
}


extension Collection where Element: Identifiable {
    func index(matching card: Element) -> Self.Index? {
        self.firstIndex(where: { $0.id == card.id })
    }
}
