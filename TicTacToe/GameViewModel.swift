import SwiftUI

final class GameViewModel: ObservableObject {
	let columns: [GridItem] = [GridItem(.flexible()),
							   GridItem(.flexible()),
							   GridItem(.flexible())]
	
	@Published var moves: [Move?] = Array(repeating: nil, count: 9)
	@Published var disabled = false
	@Published var alert: Alerts?

	func processPlayerMove(for position: Int) {
		if isSquareOccupied(in: moves, forIndex: position) { return }
		moves[position] = Move(player: .human, boardIndex: position)
		disabled = true
		
		if winCheck(for: .human, in: moves) {
			alert = AlertContext.humanWin
			return
		}
		
		if checkDraw(in: moves) {
			alert = AlertContext.draw
			return
		}
		
		disabled = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
			let computerPosition = computer(in: moves)
			moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
			disabled = false
			
			if winCheck(for: .computer, in: moves) {
				alert = AlertContext.computerWin
				return
			}
			
			if checkDraw(in: moves) {
				alert = AlertContext.draw
				return
			}
		}
	}
	
	func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
		return moves.contains(where: { $0?.boardIndex == index })
	}
	
	func computer(in moves: [Move?]) -> Int {
		let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
		
		// Bilgisayarın kazanabileceği hamleleri kontrol et
		let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
		let computerPositions = Set(computerMoves.map { $0.boardIndex })
		
		for pattern in winPatterns {
			let winPosition = pattern.subtracting(computerPositions)
			if winPosition.count == 1 {
				let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
				if isAvailable { return winPosition.first! }
			}
		}
		
		// İnsan oyuncunun kazanmasını engelle
		let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
		let humanPositions = Set(humanMoves.map { $0.boardIndex })
		
		for pattern in winPatterns {
			let winPosition = pattern.subtracting(humanPositions)
			if winPosition.count == 1 {
				let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
				if isAvailable { return winPosition.first! }
			}
		}
		
		// Orta kareyi seç
		let centerSquare = 4
		if !isSquareOccupied(in: moves, forIndex: centerSquare) {
			return centerSquare
		}
		
		// Rastgele kare seç
		var movePosition = Int.random(in: 0..<9)
		while isSquareOccupied(in: moves, forIndex: movePosition) {
			movePosition = Int.random(in: 0..<9)
		}
		
		return movePosition
	}
	
	func winCheck(for player: Player, in moves: [Move?]) -> Bool {
		let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
		let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
		let playerPositions = Set(playerMoves.map { $0.boardIndex })
		
		for pattern in winPatterns {
			if pattern.isSubset(of: playerPositions) { return true }
		}
		
		return false
	}
	
	func checkDraw(in moves: [Move?]) -> Bool {
		return moves.compactMap { $0 }.count == 9
	}
	
	func resetGame() {
		moves = Array(repeating: nil, count: 9)
		disabled = false
	}
}
