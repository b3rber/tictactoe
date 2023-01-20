//
//  GameView.swift
//  TicTacToe
//
//  Created by Daghefli Akram on 2023. 01. 20..
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel(difficulty: self.difficulty)

    
    var body: some View {
        //GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer()
                GridView()
                Spacer()
            }
            .disabled(viewModel.isGameBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: {alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: viewModel.resetGame))
            })
        //}
    }
}

enum Player {
    case human, computer
}
enum Difficulty {
    case easy, medium, hard
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(difficulty: .hard)
    }
}





