//
//  WordlViewModel.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Foundation
import SwiftUI

class WordlViewModel: ObservableObject {

    let width: Int
    let height: Int

    @Published var letters: [[Character?]]
    @Published var string: String = "" {
        didSet {
            for row in 0..<height {
                for column in 0..<width {
                    let currentIndex = row * width + column
                    if currentIndex >= string.count {
                        letters[row][column] = nil
                    } else {
                        letters[row][column] = [Character](string)[currentIndex]
                    }
                }
            }
        }
    }

    init(width: Int = 5, height: Int = 6) {
        self.width = width
        self.height = height
        letters = Array(
            repeating: [Character?](repeating: nil, count: width),
            count: height
        )
    }
    
}
