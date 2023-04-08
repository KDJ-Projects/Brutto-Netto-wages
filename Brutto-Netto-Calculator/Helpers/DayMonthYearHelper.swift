//
//  DayMonthYearHelper.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 03/04/2023.
//

import Foundation
import SwiftUI

struct DayMonthYearHelper {
	let workingHours: Double
	let workingDays: Double
	let monthsInYear: Double
	let averigeWorkingDaysMonth: Double
	
	init() {
		self.workingDays = 249.0
		self.workingHours = workingDays * 8.0
		self.monthsInYear = 12.0
		self.averigeWorkingDaysMonth = 20.75
	}
}

let workingDays = DayMonthYearHelper()
let workingHours = DayMonthYearHelper()
let monthsInYear = DayMonthYearHelper()
let averigeWorkingDaysMonth = DayMonthYearHelper()
