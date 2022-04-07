//
//  ContentView.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 27.09.2021.
//

import SwiftUI 

struct SetGameView: View {
    @ObservedObject var setDeckVM: SetDeckViewModel
    var body: some View {
        VStack {
            setBody
            Spacer()
            footer
        }
        .padding()
    }

    @Namespace private var SetCard
    
    var setBody: some View {
        AspectViewContainer(items: setDeckVM.deck.filter({ $0.card.dealed }),
                            aspectRatio: 2/3,
                            content: { cardVM in
                                if cardVM.card.dealed {
                                    CardView(card: cardVM)
                                        //.modifier(SetForegroundColor(cardVM.card.inSet ? 0.8 : 0.0))
                                        //.animation(Animation.linear(duration: 1.0))
                                        .matchedGeometryEffect(id: cardVM.card.id, in: SetCard)
                                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                                        .padding(.all, 1.0)
                                        .onTapGesture(perform: {
                                            withAnimation(.linear(duration: 0.4)) {
                                                setDeckVM.select(cardVM)
                                            }
                                        })
                                }
                            })
    }
    
    var footer: some View {
        HStack{
            ZStack {
                ForEach(setDeckVM.deck.reversed()) { cardvm in
                    if !cardvm.card.dealed && !cardvm.card.inSet {
                        CardView(card: cardvm)
                            .matchedGeometryEffect(id: cardvm.card.id, in: SetCard)
                            .transition(AnyTransition.asymmetric(insertion: AnyTransition.identity, removal: .identity))
                            .aspectRatio(2/3, contentMode: .fit)
                            .turnOver(.down)
                            .frame(width: 80, height: 120)
                            .onTapGesture {
                                for i in 1...3 {
                                    withAnimation(.linear(duration: 0.3).delay(Double(i) * 0.3)) {
                                        setDeckVM.dealMoreCard()
                                    }
                                }
                            }
                    }
                }
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .foregroundColor(.accentColor)
                    .frame(width: 80, height: 120)
                ForEach(setDeckVM.deck) { cardvm in
                    if cardvm.card.inSet && !cardvm.card.dealed {
                        CardView(card: cardvm)
                            .matchedGeometryEffect(id: cardvm.card.id, in: SetCard)
                            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                            .frame(width: 80, height: 120)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
        }
    }
    
 }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setDeckVM: SetDeckViewModel())
    }
}

