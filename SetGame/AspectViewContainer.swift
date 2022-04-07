//
//  AspectViewContainer.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 2.10.2021.
//

import SwiftUI

struct AspectViewContainer<Content, Item>: View where Content: View, Item: Identifiable {
    
    let items: Array<Item>
    let aspectRatio: CGFloat
    @ViewBuilder var content: (Item) -> Content
    
//    internal init(items: Array<Item>, aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> Content) {
//        self.items = items
//        self.aspectRatio = aspectRatio
//        self.content = content
//    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = widthThatFits(itemCount: items.count,
                                      in: geometry.size,
                                      itemAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: width), spacing: 0)], spacing: 0, content: {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            })
        }
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if  CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }

}






//struct AspectViewContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectViewContainer()
//    }
//}
