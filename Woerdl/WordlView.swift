//
//  ContentView.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Combine
import SwiftUI

struct WordlView: View {

    @ObservedObject var viewModel = WordlViewModel()

    @FocusState var showTextField: Bool

    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: viewModel.width)
    }

    var squareCount: Int {
        viewModel.width * viewModel.height
    }
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                ForEach(0..<viewModel.height) { row in
                    ForEach(0..<viewModel.width) { column in
                        return LetterBox(letter: viewModel.letters[row][column])
                            .id("LetterBox_\(row)×\(column)")
                    }
                }
            }
            TextField("•", text: $viewModel.string)
                .onChange(of: viewModel.string) { string in
                    if string.count > squareCount {
                        viewModel.string = String(string.prefix(squareCount))
                    }
                }
                .focused($showTextField)
                .opacity(0)
            Button {
                showTextField.toggle()
            } label: {
                Color.clear.contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WordlView()
        }
    }
}

extension Shape {
    
    func style<StrokeStyle: ShapeStyle, FillStyle: ShapeStyle>(
        withStroke strokeContent: StrokeStyle,
        lineWidth: CGFloat = 1,
        fill fillContent: FillStyle
    ) -> some View {
        stroke(strokeContent, lineWidth: lineWidth)
            .background(fill(fillContent))
    }
    
}
