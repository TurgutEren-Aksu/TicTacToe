//
//  ContentView.swift
//  TicTacToe
//
//  Created by Turgut Eren Aksu on 25.01.2024.
//

import SwiftUI


struct ContentView: View {
	@StateObject private var viewModel = GameViewModel()
	
	var body: some View {
		GeometryReader{ geometry in
			VStack{
				Spacer()
				LazyVGrid(columns: viewModel.columns, spacing: 5){
					ForEach(0..<9){ i in
						ZStack{
							Circle()
								.foregroundColor(.black)
								.opacity(1)
								.frame(width: geometry.size.width/3-15, height: geometry.size.width/3-15)
							Image(systemName: moves[i]?.inducator ?? "")
								.resizable()
								.frame(width: 40, height: 40)
								.foregroundColor(.red)
						}
						.onTapGesture {
							
						}
					}
				}
				Spacer()
			}
			.disabled(disabled)
			.padding()
			.alert(item: $alert, content: {alert in
				Alert(title: alert.title, message: alert.message, dismissButton: .default(alert.buttonTitle, action: { resetGame() }))
			})
		}
	}
}


enum Player{
	case human, computer
}


struct Move {
	let player: Player
	let boardIndex: Int
	var inducator: String {
		return player == .human ? "xmark" : "circle"
	}
}


#Preview {
	ContentView()
}
