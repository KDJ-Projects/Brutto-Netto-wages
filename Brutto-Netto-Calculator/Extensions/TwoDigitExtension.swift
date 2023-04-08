//
//  TwoDigitExtension.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 06/04/2023.
//

import Foundation


// Extension to round digits to 2 decimals
extension Double {
	func rounded(toPlaces places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
