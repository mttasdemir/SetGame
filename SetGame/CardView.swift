//
//  CardView.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 28.09.2021.
//

import SwiftUI


struct CardView: View {
    
    let card: CardViewModel
    
    var body: some View {
        ZStack {
            let backgroundRec = RoundedRectangle(cornerRadius: 10)
            let cardFigure = CardFigure(content: card.figure, numberOfContent: card.numberOfFigure)
            
            backgroundRec.foregroundColor(card.backgroundColor)
            backgroundRec.strokeBorder(Color.blue, lineWidth: 4)
            if card.pattern == Pattern.empty {
                cardFigure.stroke(lineWidth: 2).foregroundColor(card.color)
            } else {
                cardFigure.foregroundColor(card.color).opacity(card.opacity)
            }
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static let cardVM = CardViewModel(Card(id: 1, figure: Figure.diamond, colour: Colour.purple, numberOfFigure: Numeral.double, pattern: Pattern.full))
    static var previews: some View {
        CardView(card: cardVM)
    }
}
