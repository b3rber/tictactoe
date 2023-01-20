//
//  PlayerIndicator.swift
//  TicTacToe
//
//  Created by Daghefli Akram on 2023. 01. 20..
//

import SwiftUI

struct PlayerIndicator: View {
    
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
