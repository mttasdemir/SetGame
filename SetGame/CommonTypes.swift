//
//  CommonTypes.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 27.09.2021.
//

import Foundation

enum Figure: CaseIterable {
    case diamond
    case rectangle
    case ellipse
}

enum Numeral: CaseIterable {
    case single
    case double
    case triple
}

enum Colour: CaseIterable {
    case purple
    case green
    case red

}

enum Pattern: CaseIterable {
    case empty
    case full
    case striped
}

enum BackgroundColor {
    case white
    case gray
}
