//
//  LetterBox.swift
//  Woerdl
//
//  Created by Mischa (Privat) on 16.01.22.
//

import SwiftUI

struct LetterBox: View {
    let letter: Character?
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 4)
                .style(withStroke: .secondary, lineWidth: 2, fill: .primary)
                .aspectRatio(1, contentMode: .fill)
            if let letter = letter {
                Text(String(letter))
                    .textCase(.uppercase)
                    .multilineTextAlignment(.center)
                    .font(.system(.title).weight(.bold))
                    .foregroundColor(Color(.systemBackground))
            }
        }
    }
}

struct LetterBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LetterBox(letter: .init("A"))
                .previewLayout(.fixed(width: 100, height: 100))
        }
    }
}
