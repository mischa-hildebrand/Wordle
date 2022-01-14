//
//  WoerdlApp.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import SwiftUI

@main
struct WoerdlApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(letters: .constant([String](repeating: "", count: ContentView.width * ContentView.height)))
        }
    }
}
