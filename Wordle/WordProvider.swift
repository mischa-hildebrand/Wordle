//
//  WordProvider.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 17.01.22.
//

import Foundation

struct WordProvider {
    
    static let allowedWords: [String] = ["Table", "Chair", "Hello", "Happy"]
    
    static func generateWord() -> String {
        Self.allowedWords.randomElement()!
    }
    
}
