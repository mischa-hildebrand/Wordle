//
//  WordlViewModel.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Foundation
import SwiftUI

class WordlViewModel: ObservableObject {

    let width = 5
    let height = 6

    @Published var letters: [String] = []

    init() {
        letters = .init(repeating: "", count: width * height)
    }

}
