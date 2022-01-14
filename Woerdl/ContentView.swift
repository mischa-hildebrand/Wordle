//
//  ContentView.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import SwiftUI

struct ContentView: View {
    let width = 5
    let height = 6

    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: width)
    }

    private var squareCount: Int {
        width * height
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                ForEach(1...squareCount, id: \.self) { index in
                    ZStack() {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(4)
                        TextField("\(index)", text: .constant("\(index)"))
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
        ContentView()
    }
}
