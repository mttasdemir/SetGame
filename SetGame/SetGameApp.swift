//
//  SetGameApp.swift
//  SetGame
//
//  Created by Mustafa Taşdemir on 27.09.2021.
//

import SwiftUI

@main
struct SetGameApp: App {
    let setDeckVM = SetDeckViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(setDeckVM: setDeckVM)
        }
    }
}
