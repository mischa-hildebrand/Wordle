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
                        ZStack() {
                            Rectangle()
                                .aspectRatio(1, contentMode: .fill)
                                .cornerRadius(4)
                            Text(String(viewModel.letters[row][column] ?? Character(" ")))
                                .multilineTextAlignment(.center)
                                .font(.system(.title))
                                .foregroundColor(.white)
                        }
                        .id("matrix_\(row)x\(column)")
                    }
                    .id("row_\(row)")
                }
            }
            TextField("•", text: $viewModel.string)
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
        WordlView()
    }
}
