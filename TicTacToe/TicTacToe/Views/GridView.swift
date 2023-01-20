//
//  TileView.swift
//  TicTacToe
//
//  Created by Daghefli Akram on 2023. 01. 20..
//

import SwiftUI

struct GridView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        LazyVGrid(columns: viewModel.columns, spacing: 5) {
            ForEach(0..<9) { i in
                ZStack {
                    GameSquareView()
                    PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                }
                .onTapGesture {
                    viewModel.processPlayerMove(for: i)
                }
            }
        }
    }
}
