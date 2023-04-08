//
//  LeaseCarCalculations.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 06/04/2023.
//

import Foundation
import SwiftUI

class LeaseCalulations: ObservableObject {

	var monthlyLeaseAmount = ""
	var monthlyGasExpense = ""
	var totalYearLeaseCost = ""
	
//	@Published var calculateTotalLeaseCost = 0.0
	
	var calculateTotalLeaseCost: Double {
		guard let m = Double(self.monthlyLeaseAmount),
			  let n = Optional(Double(12.0)) else { return 0 }
		return (m * n).rounded(toPlaces: 2)
	}
	
	var calculateTotalFuelCost: Double {
		guard let m = Double(self.monthlyGasExpense),
			  let n = Optional(Double(12.0)) else { return 0 }
		return (m * n).rounded(toPlaces: 2)
	}
}
