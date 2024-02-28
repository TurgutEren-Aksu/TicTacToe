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
							TicTacToeSquareView(proxy: geometry)
							GameImage(image: viewModel.moves[i]?.inducator ?? " ")
						}
						.onTapGesture {
							viewModel.processPlayerMove(for: i)
						}
					}
				}
				Spacer()
			}
			.disabled(viewModel.disabled)
			.padding()
			.alert(item: $viewModel.alert, content: {alert in
				Alert(title: alert.title, message: alert.message, dismissButton: .default(alert.buttonTitle, action: { viewModel.resetGame() }))
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

struct TicTacToeSquareView: View {
	
	var proxy: GeometryProxy
	
	var body: some View {
		Circle()
			.foregroundColor(.black)
			.opacity(1)
			.frame(width: proxy.size.width/3-15,
				   height: proxy.size.width/3-15)
	}
}

struct GameImage: View {
	
	var image: String
	
	var body: some View {
		Image(systemName: image)
			.resizable()
			.frame(width: 40, height: 40)
			.foregroundColor(.red)
	}
}
