//
//  GameViewModel.swift
//  XOXGame
//
//  Created by ali ata haktan çetinkol on 20.05.2025.
//


import SwiftUI
import Foundation

class GameViewModel: ObservableObject {
    @Published private(set) var logic: GameLogic
    @Published var currentPlayer: Player = .x
    @Published var winner: Player?
    @Published var isDraw: Bool = false
    @Published var scores: [Player: Int] = [.x: 0, .o: 0]
    @Published var matches: [Match] = []

    let boardSize: Int

    init(size: Int) {
        self.boardSize = size
        self.logic = GameLogic(size: size)
    }

    func cellTitle(row: Int, col: Int) -> String {
        logic.board[row][col]?.rawValue ?? ""
    }

    func makeMove(row: Int, col: Int) {
        guard winner == nil else { return }

        if logic.makeMove(row: row, col: col, player: currentPlayer) {
            let newMatches = logic.findTriplets(for: currentPlayer)
            let uniqueMatches = newMatches.filter { !matches.contains($0) }

            matches.append(contentsOf: uniqueMatches)
            scores[currentPlayer, default: 0] += uniqueMatches.count

            if logic.isFull() {
                if scores[.x]! > scores[.o]! {
                    winner = .x
                } else if scores[.o]! > scores[.x]! {
                    winner = .o
                } else {
                    isDraw = true
                }
            } else {
                currentPlayer = currentPlayer == .x ? .o : .x
            }
        }
    }

    func resetGame() {
        logic = GameLogic(size: boardSize)
        currentPlayer = .x
        winner = nil
        isDraw = false
        matches = []
        scores = [.x: 0, .o: 0]
    }
}

