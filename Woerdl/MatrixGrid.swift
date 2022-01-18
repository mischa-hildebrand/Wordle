//
//  MatrixGrid.swift
//  Woerdl
//
//  Created by Mischa Hildebrand on 18.01.22.
//

import SwiftUI

struct MatrixGrid<Content: View>: View {

    typealias GridViewFactory = (_ row: Int, _ column: Int) -> Content

    let width: Int
    let height: Int
    let spacing: CGFloat
    private let makeGridView: (_ row: Int, _ column: Int) -> Content

    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: width)
    }

    init(width: Int, height: Int, spacing: CGFloat, gridViewFactory: @escaping GridViewFactory) {
        self.width = width
        self.height = height
        self.spacing = spacing
        self.makeGridView = gridViewFactory
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
            ForEach(0..<height) { row in
                ForEach(0..<width) { column in
                    makeGridView(row, column)
                }
            }
        }
    }
}

