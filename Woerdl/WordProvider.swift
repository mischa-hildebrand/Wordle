//
//  WordProvider.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 17.01.22.
//

import Foundation

struct WordProvider {
    private let wordList: [String] = ["Table", "Chair", "Hello", "Happy"]
    func generateWord() -> String {
        wordList.randomElement()!
    }
}
