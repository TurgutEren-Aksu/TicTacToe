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
	@State private var disabled = false
	@State private var alert: Alerts?
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
							disabled = true
							if winCheck(for: .human, in: moves){
								alert = AlertContext.humanWin
								return
							}
							if checkDraw(in: moves){
								alert = AlertContext.draw
								return
							}
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
								let computerPosition = computer(in: moves)
								moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
								disabled = false
								if winCheck(for: .computer, in: moves){
									alert = AlertContext.computerWin
									return
								}
								if checkDraw(in: moves){
									alert = AlertContext.draw
									return
								}
							}
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
	
	func isSquareOccupied(in moves: [Move?], forIndex index:Int) -> Bool{
		return moves.contains(where: {$0?.boardIndex == index})
	}
	func computer(in moves: [Move?]) -> Int{
		let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		
		let computerMove = moves.compactMap{ $0 }.filter{ $0.player == .computer}
		let computerPosition = Set(computerMove.map{$0.boardIndex})
		
		var movePosition = Int.random(in: 0..<9)
		
		while isSquareOccupied(in: moves, forIndex: movePosition){
			movePosition = Int.random(in: 0..<9)
		}
		
		return movePosition
	}
	
	
	func winCheck(for player: Player, in moves: [Move?]) -> Bool {
		let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		let playerMove = moves.compactMap{ $0 }.filter{ $0.player == player }
		let playerPosition = Set(playerMove.map{$0.boardIndex})
		for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return false }
		return true
	}
	func checkDraw(in moves: [Move?]) -> Bool{
		return moves.compactMap{ $0 }.count == 9
	}
	func resetGame(){
		moves = Array(repeating: nil, count: 9)
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
