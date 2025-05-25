//
//  GameLogic.swift
//  XOXGame
//
//  Created by ali ata haktan çetinkol on 20.05.2025.
//

import Foundation
enum Player: String {
    case x = "X"
    case o = "O"
}

struct GameLogic {
    let size: Int
    private(set) var board: [[Player?]]
    
    init(size: Int) {
        self.size = size
        self.board = Array(repeating: Array(repeating: nil, count: size), count: size)
    }
    
    mutating func makeMove(row: Int, col: Int, player: Player) -> Bool {
        if board[row][col] == nil {
            board[row][col] = player
            return true
        }
        return false
    }
    
    func isFull() -> Bool {
        for row in board {
            if row.contains(nil) {
                return false
            }
        }
        return true
    }

    func findTriplets(for player: Player) -> [Match] {
        var matches: [Match] = []

        // Satırlar
        for row in 0..<size {
            for col in 0...(size - 3) {
                if board[row][col] == player &&
                   board[row][col+1] == player &&
                   board[row][col+2] == player {
                    matches.append(Match(start: (row, col), end: (row, col+2), player: player))
                }
            }
        }

        // Sütunlar
        for col in 0..<size {
            for row in 0...(size - 3) {
                if board[row][col] == player &&
                   board[row+1][col] == player &&
                   board[row+2][col] == player {
                    matches.append(Match(start: (row, col), end: (row+2, col), player: player))
                }
            }
        }

        // Sağ çapraz
        for row in 0...(size - 3) {
            for col in 0...(size - 3) {
                if board[row][col] == player &&
                   board[row+1][col+1] == player &&
                   board[row+2][col+2] == player {
                    matches.append(Match(start: (row, col), end: (row+2, col+2), player: player))
                }
            }
        }

        // Sol çapraz
        for row in 0...(size - 3) {
            for col in 2..<size {
                if board[row][col] == player &&
                   board[row+1][col-1] == player &&
                   board[row+2][col-2] == player {
                    matches.append(Match(start: (row, col), end: (row+2, col-2), player: player))
                }
            }
        }

        return matches
    }
}
