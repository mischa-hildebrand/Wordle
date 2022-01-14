//
//  ContentView.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import SwiftUI

struct WordlView: View {
    static let width = 5
    static let height = 6
    @Binding var letters: [String]

    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: Self.width)
    }

    var squareCount: Int {
        Self.width * Self.height
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                ForEach(1...squareCount, id: \.self) { index in
                    ZStack() {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(4)
                        TextField("•", text: $letters[index - 1])
                            .multilineTextAlignment(.center)
                            .font(.system(.title))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordlView(letters: .constant([String](repeating: "", count: WordlView.width * WordlView.height)))
    }
}
