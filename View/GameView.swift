//
//  GameView.swift
//  XOXGame
//
//  Created by ali ata haktan çetinkol on 20.05.2025.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Oyuncu: \(viewModel.currentPlayer.rawValue)")
                .font(.title)
                .bold()
                .foregroundColor(.primary)

            ZStack {
                GridView(viewModel: viewModel)

                GeometryReader { geo in
                    ForEach(viewModel.matches) { match in
                        let cellSize: CGFloat = 44
                        let spacing: CGFloat = 4

                        let startX = CGFloat(match.start.1) * (cellSize + spacing) + cellSize / 2
                        let startY = CGFloat(match.start.0) * (cellSize + spacing) + cellSize / 2
                        let endX = CGFloat(match.end.1) * (cellSize + spacing) + cellSize / 2
                        let endY = CGFloat(match.end.0) * (cellSize + spacing) + cellSize / 2

                        Path { path in
                            path.move(to: CGPoint(x: startX, y: startY))
                            path.addLine(to: CGPoint(x: endX, y: endY))
                        }
                        .stroke(match.player == .x ? .red : .green, lineWidth: 4)
                    }
                }
            }
            .frame(width: CGFloat(viewModel.boardSize) * 48,
                   height: CGFloat(viewModel.boardSize) * 48)

            if let winner = viewModel.winner {
                Text("Kazanan: \(winner.rawValue)")
                    .font(.title2)
                    .foregroundColor(.green)
            } else if viewModel.isDraw {
                Text("Berabere!")
                    .font(.title2)
                    .foregroundColor(.orange)
            }

            Button("Yeniden Başlat") {
                viewModel.resetGame()
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            HStack {
                Text("X Skor: \(viewModel.scores[.x] ?? 0)")
                Spacer()
                Text("O Skor: \(viewModel.scores[.o] ?? 0)")
            }
            .padding(.horizontal)
            .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
