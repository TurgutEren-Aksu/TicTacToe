//
//  ContentView.swift
//  TicTacToe
//
//  Created by Turgut Eren Aksu on 25.01.2024.
//

import SwiftUI


struct ContentView: View {
	let columns: [GridItem] = [GridItem(.flexible()),
							   GridItem(.flexible()),
							   GridItem(.flexible())]
	@State private var moves: [Move?] = Array(repeating: nil, count: 9)
	@State private var isHumanTurn = true
	var body: some View {
		GeometryReader{ geometry in
			VStack{
				Spacer()
				LazyVGrid(columns: columns, spacing: 5){
					ForEach(0..<9){ i in
						ZStack{
							Circle()
								.foregroundColor(.black)
								.opacity(1)
								.frame(width: geometry.size.width/3-15, height: geometry.size.width/3-15)
							Image(systemName: moves[i]?.inducator ?? "")
								.resizable()
								.frame(width: 40, height: 40)
								.foregroundColor(.white)
						}
						.onTapGesture {
							moves[i] = Move(player: isHumanTurn ? .human : .computer, boardIndex: i)
							isHumanTurn.toggle()
						}
					}
				}
				Spacer()
				// dont use spacer you must be editing
			}
			.padding()
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
