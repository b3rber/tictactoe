//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Daghefli Akram on 2023. 01. 20..
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .human, boardIndex: position)
        isGameBoardDisabled = true
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves, difficulty: self.difficulty)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameBoardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
            }
        }
    }
    
    func isSquareOccupied(in move: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determineComputerMovePosition(in moves: [Move?], difficulty: Difficulty) -> Int {
        let winPatterns : Set<Set<Int>> = [[0, 1 ,2], [3, 4, 5], [6, 7 ,8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        switch difficulty {
        case .medium:
            // Mark 2
            let humanMoves = moves.compactMap({ $0 }).filter { $0.player == .human }
            let humanPositions = Set(humanMoves.map { $0.boardIndex } )
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(humanPositions)
                
                if winPositions.count == 1 {
                    let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvaiable { return winPositions.first!}
                }
            }
            // Mark 3
            let centerSquare = 4
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {return centerSquare}
            
            
            // Mark 4
            var movePosition = Int.random(in: 0..<9)
            
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
            
            return movePosition
        case .hard:
            // Mark 1
            let winPatterns : Set<Set<Int>> = [[0, 1 ,2], [3, 4, 5], [6, 7 ,8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
            
            let computerMoves = moves.compactMap({ $0 }).filter { $0.player == .computer }
            let computerPositions = Set(computerMoves.map { $0.boardIndex } )
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(computerPositions)
                
                if winPositions.count == 1 {
                    let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvaiable { return winPositions.first!}
                }
            }
            // Mark 2
            let humanMoves = moves.compactMap({ $0 }).filter { $0.player == .human }
            let humanPositions = Set(humanMoves.map { $0.boardIndex } )
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(humanPositions)
                
                if winPositions.count == 1 {
                    let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvaiable { return winPositions.first!}
                }
            }
            // Mark 3
            let centerSquare = 4
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {return centerSquare}
            
            
            // Mark 4
            var movePosition = Int.random(in: 0..<9)
            
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
            
            return movePosition
        case .easy:
            // Mark 3
            let centerSquare = 4
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {return centerSquare}
            
            
            // Mark 4
            var movePosition = Int.random(in: 0..<9)
            
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
            
            return movePosition
        }
        /* Mark 1
         let winPatterns : Set<Set<Int>> = [[0, 1 ,2], [3, 4, 5], [6, 7 ,8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
         
         let computerMoves = moves.compactMap({ $0 }).filter { $0.player == .computer }
         let computerPositions = Set(computerMoves.map { $0.boardIndex } )
         
         for pattern in winPatterns {
         let winPositions = pattern.subtracting(computerPositions)
         
         if winPositions.count == 1 {
         let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
         if isAvaiable { return winPositions.first!}
         }
         }
         // Mark 2
         let humanMoves = moves.compactMap({ $0 }).filter { $0.player == .human }
         let humanPositions = Set(humanMoves.map { $0.boardIndex } )
         
         for pattern in winPatterns {
         let winPositions = pattern.subtracting(humanPositions)
         
         if winPositions.count == 1 {
         let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
         if isAvaiable { return winPositions.first!}
         }
         }
         // Mark 3
         let centerSquare = 4
         if !isSquareOccupied(in: moves, forIndex: centerSquare) {return centerSquare}
         
         
         // Mark 4
         var movePosition = Int.random(in: 0..<9)
         
         while isSquareOccupied(in: moves, forIndex: movePosition) {
         movePosition = Int.random(in: 0..<9)
         }
         
         return movePosition
         */
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns : Set<Set<Int>> = [[0, 1 ,2], [3, 4, 5], [6, 7 ,8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap({ $0 }).filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex } )
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap {$0}.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameBoardDisabled = false
    }
}
