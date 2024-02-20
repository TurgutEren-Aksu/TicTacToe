//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Turgut Eren Aksu on 18.02.2024.
//

import SwiftUI

final class GameViewModel: ObservableObject{
	let columns: [GridItem] = [GridItem(.flexible()),
							   GridItem(.flexible()),
							   GridItem(.flexible())]
	
	@Published var moves: [Move?] = Array(repeating: nil, count: 9)
	@Published var disabled = false
	@Published var alert: Alerts?
	
}
