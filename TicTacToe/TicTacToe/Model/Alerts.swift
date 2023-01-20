//
//  Alerts.swift
//  TicTacToe
//
//  Created by Daghefli Akram on 2023. 01. 20..
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    
    init(title: String, message: String, buttonTitle: String) {
        self.title = Text(title)
        self.message = Text(message)
        self.buttonTitle = Text(buttonTitle)
    }
}

struct AlertContext {
    static let humanWin = AlertItem(title: "Nyertél!", message: "Sikerült legyőznöd az AI-t", buttonTitle: "Nyomod!")
    static let computerWin = AlertItem(title: "Gatya", message: "A helyedben elásnám magam", buttonTitle: "Rotyogjon újra!")
    static let draw = AlertItem(title: "Döntetlen", message: "Rosszabb, mintha veszítettél volna", buttonTitle: "Visszavágót!")
}
