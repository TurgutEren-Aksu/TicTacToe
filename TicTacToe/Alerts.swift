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
