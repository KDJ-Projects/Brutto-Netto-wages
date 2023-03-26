//
//  DaysOffCalculation.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 06/02/2023.
//

import Foundation

func calculatDaysOff() {
    // MARK: Variables 2023
    /// Total non- and working days 2023
    let totalWorkingDays: Int = 249
    let totalNoneWorkingDays: Int = 116
    
    /// Vacation days when you work for a boss
    let annualYearlyLeaveDays: Int = 20
    let annualWorkingReduductionDays: Int = 12
    let annualPaydHolidays: Int = 10
    
    /// Total days work minus days off
    let totalDaysOff: Int = annualYearlyLeaveDays + annualWorkingReduductionDays + annualPaydHolidays
    let totalWorkingMinusDaysOff: Int = totalWorkingDays - totalDaysOff
    
    // MARK: Calculations
    /// Calculate yearly leave days wages
    var calculateYearlyLeaveDayWages: Double {
        guard let days = Optional(annualYearlyLeaveDays)
                
        else { return 0 }
        return Double(days)
    }
}
