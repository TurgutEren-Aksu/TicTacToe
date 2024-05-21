import Foundation
import SwiftUI

struct Alerts: Identifiable {
	let id = UUID()
	var title: Text
	var message: Text
	var buttonTitle: Text
}

struct AlertContext {
	static var humanWin = Alerts(title: Text("Kazandınız"), message: Text("Kendi yapay zekanızı yendiniz"), buttonTitle: Text("Tekrar Oyna"))
	static var computerWin = Alerts(title: Text("Kaybettiniz"), message: Text("Yapay zeka sizi yendi"), buttonTitle: Text("Tekrar Oyna"))
	static var draw = Alerts(title: Text("Berabere"), message: Text("İyi bir mücadele oldu..."), buttonTitle: Text("Tekrar Oyna"))
}
