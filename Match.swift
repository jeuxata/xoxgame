//
//  Match.swift
//  XOXGame
//
//  Created by ali ata haktan çetinkol on 20.05.2025.
//
import Foundation

struct Match: Identifiable, Hashable {
    let id = UUID()
    let start: (Int, Int)
    let end: (Int, Int)
    let player: Player

    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.start == rhs.start &&
               lhs.end == rhs.end &&
               lhs.player == rhs.player
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(start.0)
        hasher.combine(start.1)
        hasher.combine(end.0)
        hasher.combine(end.1)
        hasher.combine(player)
    }
}

