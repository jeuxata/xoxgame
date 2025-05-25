//
//  Grid.swift
//  XOXGame
//
//  Created by ali ata haktan çetinkol on 20.05.2025.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        let size = viewModel.boardSize
        VStack(spacing: 4) {
            ForEach(0..<size, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(0..<size, id: \.self) { col in
                        Button(action: {
                            viewModel.makeMove(row: row, col: col)
                        }) {
                            Text(viewModel.cellTitle(row: row, col: col))
                                .frame(width: 44, height: 44)
                                .font(.title2)
                                .foregroundColor(.white)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(6)
                        }
                    }
                }
            }
        }
    }
}
