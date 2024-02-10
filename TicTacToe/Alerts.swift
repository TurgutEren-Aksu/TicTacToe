//
//  Alerts.swift
//  TicTacToe
//
//  Created by Turgut Eren Aksu on 9.02.2024.
//

import Foundation
import SwiftUI

struct Alerts: Identifiable{
	let id = UUID()
	var title: Text
	var message: Text
	var buttonTitle: Text
}
struct AlertContext {
	var humanWin = Alerts(title: Text("You Win"), message: Text("You beat your own AI"), buttonTitle: Text("Hell Yeah"))
	var computerWin = Alerts(title: Text("You Lost"), message: Text("You programmed as super AI"), buttonTitle: Text("Rematch"))
	var draw = Alerts(title: Text("Draw"), message: Text("What a battle of wits we have here..."), buttonTitle: Text("Try Again"))

}
