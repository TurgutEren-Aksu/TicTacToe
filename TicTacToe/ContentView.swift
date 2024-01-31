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
								.foregroundColor(.red)
						}
						.onTapGesture {
							if isSquareOccupied(in: moves, forIndex: i) {return}
								moves[i] = Move(player: .human, boardIndex: i)
						}
					}
				}
				Spacer()
				// dont use spacer you must be editing
			}
			.padding()
		}
	}
	
	func isSquareOccupied(in moves: [Move?], forIndex index:Int) -> Bool{
		return moves.contains(where: {$0?.boardIndex == index})
	}
	func computer(in moves: [Move?]) -> Int{
		var movePosition = Int.random(in: 0..<9)
		
		while isSquareOccupied(in: moves, forIndex: movePosition){
			var movePosition = Int.random(in: 0..<9)
		}
		
		return movePosition
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
