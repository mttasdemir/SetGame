//
//  CardFigure.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 28.09.2021.
//

import SwiftUI

struct CardFigure: Shape {
    let content: Figure
    let numberOfContent: Int
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width*2 / 3
        let height = rect.height / 6
        let padding = height / 6
        let sliding = height/2 + padding/2
        let origin = CGPoint(x: rect.midX-width/2, y: rect.midY-height/2)
        let origins: [[CGPoint]] = [
            [origin],
            [CGPoint(x: origin.x, y: origin.y-sliding), CGPoint(x: origin.x, y: origin.y + sliding)],
            [CGPoint(x: origin.x, y: origin.y-(padding+height)), CGPoint(x: origin.x, y: origin.y), CGPoint(x: origin.x, y: origin.y + height + padding)],
        ]
        
        switch content {
            case .diamond: return drawDiamondPath(origins[numberOfContent], width, height)
            case .rectangle: return drawRectanglePath(origins[numberOfContent], width, height)
            case .ellipse: return drawEllipsePath(origins[numberOfContent], width, height)
        }
        
    }
    
    private func drawDiamondPath(_ origin: [CGPoint], _ width: CGFloat, _ height: CGFloat) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        
        for index in origin.indices {
            let center = CGPoint(x: origin[index].x + width/2, y: origin[index].y)
            p.move(to: center)
            p.addLine(to: CGPoint(x: center.x - width/2, y: center.y + height/2))
            p.addLine(to: CGPoint(x: center.x, y: center.y + height))
            p.addLine(to: CGPoint(x: center.x + width/2, y: center.y + height/2))
            p.addLine(to: center)
        }
        return p
    }
    
    private func drawRectanglePath(_ origin: [CGPoint], _ width: CGFloat, _ height: CGFloat) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        
        for index in origin.indices {
            p.addRect(CGRect(origin: CGPoint(x: origin[index].x, y: CGFloat(origin[index].y)), size: CGSize(width: width, height: height)))
        }
        return p
    }
    
    private func drawEllipsePath(_ origin: [CGPoint], _ width: CGFloat, _ height: CGFloat) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        for index in origin.indices {
            p.addEllipse(in: CGRect(origin: CGPoint(x: origin[index].x, y: CGFloat(origin[index].y)), size: CGSize(width: width, height: height)))
        }
        return p
    }
    
}

