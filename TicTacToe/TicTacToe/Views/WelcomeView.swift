//
//  WelcomeView.swift
//  TicTacToe
//
//  Created by Daghefli Akram on 2023. 01. 20..
//

import SwiftUI

struct WelcomeView: View {
    
    @State var showGameView = false
    @State var selectedDifficulty = Difficulty.easy
    var body: some View {
        VStack{
            if self.showGameView {
                VStack {
                    GameView(difficulty: self.selectedDifficulty)
                }
            } else {
                Spacer()
                Text("A célod legyőzni az AI-t.")
                    .font(.largeTitle)
                HStack {
                    Button("Könnyű") {
                        self.selectedDifficulty = Difficulty.easy
                        self.showGameView = true
                    }
                    Button("Közepes") {
                        self.selectedDifficulty = Difficulty.medium
                        self.showGameView = true
                    }
                    Button("Nehéz") {
                        self.selectedDifficulty = Difficulty.hard
                        self.showGameView = true
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
