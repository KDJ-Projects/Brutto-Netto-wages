//
//  TaxBracketHelper.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 03/04/2023.
//

import Foundation
import SwiftUI

struct TaxBracketHelper {
	let tax_25: Double
	let tax_40: Double
	let tax_45: Double
	let tax_50: Double
	let vatPercentage: Double
	
	init() {
		self.tax_25 = 0.25 // from 0.00 to 13.870,00
		self.tax_40 = 0.40 // from 13.870,00 to 24.480,00
		self.tax_45 = 0.45 // from 24.480,00 to 42.370,00
		self.tax_50 = 0.50 // from 42.370,00 to ...
		self.vatPercentage = 0.21
	}
}

var bracket25 = TaxBracketHelper()
var bracket40 = TaxBracketHelper()
var bracket45 = TaxBracketHelper()
var bracket50 = TaxBracketHelper()
var vat = TaxBracketHelper()
