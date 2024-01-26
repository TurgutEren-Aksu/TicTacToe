//
//  ContentView.swift
//  TicTacToe
//
//  Created by Turgut Eren Aksu on 25.01.2024.
//

import SwiftUI

let columns: [GridItem] = [GridItem(.flexible()),
						   GridItem(.flexible()),
						   GridItem(.flexible())]

struct ContentView: View {
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
							Image(systemName: "xmark")
								.resizable()
								.frame(width: 40, height: 40)
								.foregroundColor(.white)
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
struct move {
	let player: Player
	let boardIndex: Int
	var inducator: String {
		return player == .human ? "xmark" : "circle"
	}
}
#Preview {
	ContentView()
}
